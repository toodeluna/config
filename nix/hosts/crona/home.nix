{
  colors,
  config,
  lib,
  osConfig,
  pkgs,
  self,
  user,
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

  programs.lutris.enable = false;
  programs.nix-your-shell.enable = true;
  programs.opencode.enable = true;
  programs.vesktop.enable = true;

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };

  catppuccin = {
    inherit (osConfig.catppuccin) enable flavor accent;
    sources.palette = osConfig.catppuccin.sources.palette;
    anki.enable = false;
    mpv.enable = false;
  };

  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = 0.95;
      confirm_os_window_close = 0;

      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
    };
  };

  programs.anki = {
    enable = true;

    profiles.${user.name} = {
      default = true;

      sync = {
        url = "https://anki.toodeluna.net";
        keyFile = config.age.secrets."anki/key".path;
        autoSync = true;
        syncMedia = true;
        username = user.name;
      };
    };
  };

  age = {
    secretsDir = "${config.home.homeDirectory}/.local/state/agenix";
    secretsMountPoint = "${config.home.homeDirectory}/.local/state/agenix.d";
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

    secrets = {
      "anki/key".file = "${self}/nix/secrets/crona/anki/key.age";
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
    configs.default = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/projects/code/config/cfg/quickshell";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "Host blackstar" = {
        HostName = "toodeluna.net";
        User = "luna";
      };

      "Host crona" = {
        HostName = "crona.local";
        User = "luna";
      };

      "Host tsubaki" = {
        HostName = "tsubaki.local";
        User = "luna";
      };
    };
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
        name = user.fullName;
        email = user.email;
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

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;

    extraConfig =
      let
        keyboard = {
          inherit (osConfig.services.xserver.xkb) layout options;
        };

        packages = {
          xwayland_satellite = lib.getExe pkgs.xwayland-satellite;
          zen = lib.getExe config.programs.zen-browser.package;
          wl_copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
          quickshell = lib.getExe pkgs.quickshell;
          kitty = lib.getExe pkgs.kitty;
          rofi = lib.getExe pkgs.rofi;
          hyprshot = lib.getExe pkgs.hyprshot;
          hyprpicker = lib.getExe pkgs.hyprpicker;
        };
      in
      ''
        local xkb = ${lib.generators.toLua { } keyboard}
        local packages = ${lib.generators.toLua { } packages}

        ${builtins.readFile "${self}/cfg/hypr/hyprland.lua"}
      '';
  };

  xdg.configFile."quickshell.json".text = builtins.toJSON {
    wallpaper = "${self}/assets/wallpapers/yamada-ryo.png";
    theme = lib.mapAttrs (name: color: color.hex) colors;
  };
}
