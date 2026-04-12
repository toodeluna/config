{
  colors,
  config,
  lib,
  osConfig,
  pkgs,
  self,
  ...
}:
let
  inherit (config.home) homeDirectory;

  nixvimArgs = {
    inherit osConfig;
    homeConfig = config;
  };

  palette = lib.getAttr config.catppuccin.flavor (
    lib.importJSON "${config.catppuccin.sources.palette}/palette.json"
  );
in
{
  _module.args = { inherit (palette) colors; };

  programs.home-manager.enable = true;
  programs.kitty.enable = true;
  programs.lutris.enable = true;
  programs.nix-your-shell.enable = true;
  programs.opencode.enable = true;

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  home = {
    stateVersion = "26.05";
    preferXdgDirectories = true;
  };

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };

  home.packages = [
    pkgs.discord
    pkgs.qbittorrent
    pkgs.spotify
  ];

  catppuccin = {
    inherit (osConfig.catppuccin) enable flavor accent;
    sources.palette = osConfig.catppuccin.sources.palette;
    mpv.enable = false;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${homeDirectory}/desktop";
    documents = "${homeDirectory}/documents";
    download = "${homeDirectory}/downloads";
    music = "${homeDirectory}/media/music";
    pictures = "${homeDirectory}/media/photos";
    publicShare = "${homeDirectory}/share";
    templates = "${homeDirectory}/templates";
    videos = "${homeDirectory}/media/videos";

    extraConfig = {
      CODE_DIR = "${homeDirectory}/code";
      GAMES_DIR = "${homeDirectory}/media/games";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    initExtra = lib.mkOrder 2000 "exec ${lib.getExe pkgs.nushell}";
  };

  programs.nushell = {
    enable = true;
    settings.show_banner = false;
  };

  programs.quickshell = {
    enable = true;
    activeConfig = "default";
    configs.default = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/code/github.com/toodeluna/config/cfg/quickshell";
  };

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${homeDirectory}/.ssh/id_ed25519.pub";
    };

    settings = {
      core.ignorecase = false;
      pull.rebase = true;
      init.defaultBranch = "main";

      user = {
        name = "Luna Heyman";
        email = "luna@toodeluna.net";
      };

      alias = {
        lga = "log --decorate --oneline --graph";
        put = "push --set-upstream";
        ui = "!${lib.getExe pkgs.lazygit}";
      };
    };
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    useGlobalPkgs = true;

    imports = [
      ./neovim.nix
      { _module.args = nixvimArgs; }
    ];
  };

  programs.mpv = {
    enable = true;

    scripts = [
      pkgs.mpvScripts.modernz
      pkgs.mpvScripts.thumbfast
    ];

    config = {
      ao = "pulse";
      osc = "no";
      target-colorspace-hint = "no";
    };

    scriptOpts.modernz = {
      icon_theme = "material";
    };
  };

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      name = "Default";
      isDefault = true;
      containersForce = true;
      spacesForce = true;
      pinsForce = true;

      settings = {
        "extensions.autoDisableScopes" = false;
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "zen.urlbar.replace-newtab" = true;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
      };

      search = {
        force = true;
        default = "ddg";
      };

      extensions = {
        force = true;

        packages = [
          pkgs.firefox-addons.catppuccin-web-file-icons
          pkgs.firefox-addons.proton-pass
          pkgs.firefox-addons.return-youtube-dislikes
          pkgs.firefox-addons.shinigami-eyes
          pkgs.firefox-addons.sponsorblock
          pkgs.firefox-addons.stylus
          pkgs.firefox-addons.ublock-origin
          pkgs.firefox-addons.yomitan
          pkgs.firefox-addons.youtube-shorts-block
        ];
      };

      containers.default = {
        color = "purple";
        icon = "fingerprint";
        id = 1;
      };

      spaces.default = {
        id = "97657b3e-278e-488b-af22-e68f8c495f04";
        position = 1000;
        container = config.programs.zen-browser.profiles.default.containers.default.id;

        theme.colors = lib.singleton {
          red = colors.base.rgb.r;
          green = colors.base.rgb.g;
          blue = colors.base.rgb.b;
        };
      };
    };
  };

  wayland.windowManager.mango = {
    enable = true;
    package = osConfig.programs.mango.package;

    autostart_sh = ''
      ${lib.getExe pkgs.xwayland-satellite} :2 &
      ${lib.getExe pkgs.quickshell} &
    '';

    settings = {
      borderpx = 2;
      border_radius = 6;

      bordercolor = "0x${builtins.substring 1 (-1) colors.overlay0.hex}ff";
      focuscolor = "0x${builtins.substring 1 (-1) colors.blue.hex}ff";

      cursor_size = config.home.pointerCursor.size;
      cursor_theme = config.home.pointerCursor.name;
    };

    settings.env = [
      "DISPLAY,:2"
    ];

    settings.monitorrule = [
      "name:DP-1,scale:1.75,width:2840,height:2160"
    ];

    settings.bind = [
      "SUPER, R, reload_config"

      "SUPER, O, toggleoverview"
      "SUPER, F, togglefloating"
      "SUPER+SHIFT_L, F, togglefullscreen"

      "SUPER, Q, killclient"
      "SUPER+SHIFT_L, Q, quit"

      "SUPER, RETURN, spawn, ${lib.getExe pkgs.kitty}"
      "SUPER, SPACE, spawn, ${lib.getExe pkgs.rofi} -show drun"
      "SUPER, B, spawn, ${lib.getExe config.programs.zen-browser.package}"

      "SUPER, H, focusdir, left"
      "SUPER, J, focusdir, down"
      "SUPER, K, focusdir, up"
      "SUPER, L, focusdir, right"

      "SUPER+SHIFT_L, H, exchange_client, left"
      "SUPER+SHIFT_L, J, exchange_client, down"
      "SUPER+SHIFT_L, K, exchange_client, up"
      "SUPER+SHIFT_L, L, exchange_client, right"

      "SUPER, 1, view, 1, 0"
      "SUPER, 2, view, 2, 0"
      "SUPER, 3, view, 3, 0"
      "SUPER, 4, view, 4, 0"
      "SUPER, 5, view, 5, 0"
      "SUPER, 6, view, 6, 0"
      "SUPER, 7, view, 7, 0"
      "SUPER, 8, view, 8, 0"
      "SUPER, 9, view, 9, 0"

      "SUPER+SHIFT, 1, tag, 1, 0"
      "SUPER+SHIFT, 2, tag, 2, 0"
      "SUPER+SHIFT, 3, tag, 3, 0"
      "SUPER+SHIFT, 4, tag, 4, 0"
      "SUPER+SHIFT, 5, tag, 5, 0"
      "SUPER+SHIFT, 6, tag, 6, 0"
      "SUPER+SHIFT, 7, tag, 7, 0"
      "SUPER+SHIFT, 8, tag, 8, 0"
      "SUPER+SHIFT, 9, tag, 9, 0"
    ];

    settings.mousebind = [
      "SUPER, BTN_LEFT, moveresize, curmove"
      "SUPER, BTN_RIGHT, moveresize, curresize"
    ];
  };

  xdg.configFile."quickshell.json".text = builtins.toJSON {
    wallpaper = "${self}/assets/wallpapers/yamada-ryo.png";
  };
}
