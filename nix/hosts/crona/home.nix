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

  programs.lutris.enable = false;
  programs.nix-your-shell.enable = true;
  programs.opencode.enable = true;
  programs.vesktop.enable = true;

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };

  catppuccin = {
    inherit (osConfig.catppuccin) enable flavor accent;
    sources.palette = osConfig.catppuccin.sources.palette;
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

    matchBlocks = {
      blackstar = {
        hostname = "toodeluna.net";
        user = "luna";
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

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;

    # TODO: Remove this when Hyprland 0.55 is on nixos-unstable.
    configType = "hyprlang";

    settings = {
      general = {
        layout = "master";

        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;
        resize_on_border = true;

        "col.active_border" = "$mauve";
        "col.inactive_border" = "$overlay0";
      };

      decoration = {
        rounding = 6;
        rounding_power = 3;

        blur = {
          enabled = true;
          passes = 2;
          size = 5;
          vibrancy = 0.15;
        };

        shadow = {
          color = "rgba($crustAlphaaa)";
          enabled = true;
          range = 6;
          render_power = 3;
        };
      };

      input = {
        kb_layout = osConfig.services.xserver.xkb.layout;
        kb_options = osConfig.services.xserver.xkb.options;

        sensitivity = 0;
        follow_mouse = true;
        touchpad.natural_scroll = true;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = false;
      };

      animations = {
        enabled = true;

        bezier = [
          "linear, 0, 0, 1, 1"
          "easeOut, 0.23, 1, 0.32, 1"
          "easeInOut, 0.28, 0.09, 0.59, 1"
        ];

        animation = [
          "global, true, 5, default"
          "border, true, 4, easeOut"
          "fade, true, 4, easeOut"
          "windows, true, 4, easeOut"
          "windowsIn, true, 4, easeOut, slide bottom"
          "windowsOut, true, 4, easeOut, gnomed"
          "workspaces, true, 1.9, easeInOut"
          "workspacesIn, true, 1.9, easeInOut, slide"
          "workspacesOut, true, 1.9, easeInOut, slide"
        ];
      };

      xwayland = {
        enabled = false;
      };

      env = [
        "DISPLAY,:2"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "${lib.getExe pkgs.xwayland-satellite} :2"
        "${lib.getExe pkgs.quickshell}"
      ];

      bind = [
        "super, return, exec, ${lib.getExe pkgs.kitty}"
        "super, space, exec, ${lib.getExe pkgs.rofi} -show drun"
        "super, b, exec, ${lib.getExe config.programs.zen-browser.package}"
        "super, s, exec, ${lib.getExe pkgs.hyprshot} --mode region --clipboard-only"
        "super, c, exec, ${lib.getExe pkgs.hyprpicker} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"

        "super, q, killactive"
        "super shift, q, exit"

        "super, f, togglefloating"
        "super shift, f, fullscreen"

        "super, h, movefocus, l"
        "super, j, movefocus, d"
        "super, k, movefocus, u"
        "super, l, movefocus, r"

        "super shift, h, movewindow, l"
        "super shift, j, movewindow, d"
        "super shift, k, movewindow, u"
        "super shift, l, movewindow, r"

        "super, 1, workspace, 1"
        "super, 2, workspace, 2"
        "super, 3, workspace, 3"
        "super, 4, workspace, 4"
        "super, 5, workspace, 5"
        "super, 6, workspace, 6"
        "super, 7, workspace, 7"
        "super, 8, workspace, 8"
        "super, 9, workspace, 9"
        "super, 0, workspace, 10"

        "super shift, 1, movetoworkspace, 1"
        "super shift, 2, movetoworkspace, 2"
        "super shift, 3, movetoworkspace, 3"
        "super shift, 4, movetoworkspace, 4"
        "super shift, 5, movetoworkspace, 5"
        "super shift, 6, movetoworkspace, 6"
        "super shift, 7, movetoworkspace, 7"
        "super shift, 8, movetoworkspace, 8"
        "super shift, 9, movetoworkspace, 9"
        "super shift, 0, movetoworkspace, 10"

        "alt, tab, workspace, previous"
      ];

      bindm = [
        "super, mouse:272, movewindow"
        "super, mouse:273, resizewindow"
      ];

      windowrule = [
        {
          name = "fix-xwayland-drags";
          no_focus = true;

          "match:class" = "^$";
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;
          "match:title" = "^$";
          "match:xwayland" = true;
        }
        {
          name = "suppress-maximize-events";
          suppress_event = "maximize";

          "match:class" = ".*";
        }
      ];
    };
  };

  xdg.configFile."quickshell.json".text = builtins.toJSON {
    wallpaper = "${self}/assets/wallpapers/yamada-ryo.png";
    theme = lib.mapAttrs (name: color: color.hex) colors;
  };
}
