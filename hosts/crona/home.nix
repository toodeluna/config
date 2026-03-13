{
  self,
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  home.preferXdgDirectories = true;

  programs.carapace.enable = true;
  programs.nix-your-shell.enable = true;
  programs.nushell.enable = true;
  programs.rofi.enable = true;
  programs.fish.enable = true;

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  programs.anki = {
    enable = true;
    profiles.luna.sync.url = "https://anki.toodeluna.net";
  };

  programs.ghostty = {
    enable = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
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
    suppressXdgMigrationWarning = true;

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

      containers = {
        personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
      };

      spaces = {
        personal = {
          id = "e01fd107-501e-4761-8638-eab2243247ea";
          position = 1000;
          container = config.programs.zen-browser.profiles.default.containers.personal.id;

          theme.colors = lib.singleton {
            red = 24;
            green = 24;
            blue = 37;
          };
        };
      };

      pins = {
        "YouTube" = {
          id = "6eac9454-77d9-47db-888a-07b9355652ac";
          container = config.programs.zen-browser.profiles.default.containers.personal.id;
          url = "https://www.youtube.com";
          isEssential = true;
          position = 101;
        };

        "Catsky" = {
          id = "f86333e0-a714-4d10-9d05-6ec6b84e29ba";
          container = config.programs.zen-browser.profiles.default.containers.personal.id;
          url = "https://catsky.social";
          isEssential = true;
          position = 102;
        };

        "GitHub" = {
          id = "3b36d7ee-879e-470e-b908-e2215b1d6c39";
          container = config.programs.zen-browser.profiles.default.containers.personal.id;
          url = "https://github.com";
          isEssential = true;
          position = 103;
        };
      };
    };
  };

  programs.quickshell = {
    enable = true;
    activeConfig = "default";
    configs.default = "${self}/quickshell";
  };

  xdg.configFile."quickshell/config.json".text = builtins.toJSON {
    wallpaper = "${self}/wallpapers/link-click.jpg";
  };

  xdg.configFile."niri/config.kdl".text = ''
    spawn-sh-at-startup "${lib.getExe pkgs.quickshell} -c ${config.programs.quickshell.activeConfig}"

    prefer-no-csd
    screenshot-path "${config.home.homeDirectory}/pictures/screenshots/%Y-%m-%d_%H-%M-%S.png"

    input {
      warp-mouse-to-focus
      focus-follows-mouse max-scroll-amount="0%"

      keyboard {
        numlock

        xkb {
          layout "${osConfig.services.xserver.xkb.layout}"
          options "${osConfig.services.xserver.xkb.options}"
        }
      }

      touchpad {
        tap
        natural-scroll
      }
    }

    layout {
      gaps 10
      background-color "transparent"

      preset-column-widths {
        proportion 0.333333
        proportion 0.500000
        proportion 0.666666
      }

      default-column-width {
        proportion 0.5
      }

      focus-ring {
        off
      }

      border {
        width 2
        active-gradient from="#cba6f7" to="#f38ba8" angle=45
        inactive-color "#6c7086"
      }

      shadow {
        on
        softness 20
        spread 1
        offset x=0 y=0
        color "#0007"
      }
    }

    hotkey-overlay {
      skip-at-startup
    }

    window-rule {
      geometry-corner-radius 4
      clip-to-geometry true
    }

    window-rule {
      match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
      default-floating-position x=0 y=0 relative-to="bottom-right"
    }

    window-rule {
      match app-id="org.kde.kdenlive"
      open-floating true
    }

    layer-rule {
      match namespace="^wallpaper$"
      place-within-backdrop true
    }

    binds {
      Mod+Shift+Slash { show-hotkey-overlay; }
      Mod+O repeat=false { toggle-overview; }

      Mod+Return hotkey-overlay-title="Open terminal" { spawn "${lib.getExe pkgs.ghostty}"; }
      Mod+Space hotkey-overlay-title="Open launcher" { spawn-sh "${lib.getExe pkgs.rofi} -show drun"; }
      Mod+B hotkey-overlay-title="Open browser" { spawn-sh "${lib.getExe config.programs.zen-browser.package} -show drun"; }

      Mod+Q repeat=false { close-window; }
      Mod+Shift+Q { quit; }

      Mod+H { focus-column-left; }
      Mod+J { focus-window-or-workspace-down; }
      Mod+K { focus-window-or-workspace-up; }
      Mod+L { focus-column-right; }

      Mod+Shift+H { move-column-left; }
      Mod+Shift+J { move-window-down-or-to-workspace-down; }
      Mod+Shift+K { move-window-up-or-to-workspace-up; }
      Mod+Shift+L { move-column-right; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      Mod+0 { focus-workspace 10; }

      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }
      Mod+Shift+6 { move-column-to-workspace 6; }
      Mod+Shift+7 { move-column-to-workspace 7; }
      Mod+Shift+8 { move-column-to-workspace 8; }
      Mod+Shift+9 { move-column-to-workspace 9; }
      Mod+Shift+0 { move-column-to-workspace 10; }

      Mod+BracketLeft { consume-or-expel-window-left; }
      Mod+BracketRight { consume-or-expel-window-right; }

      Mod+Comma { consume-window-into-column; }
      Mod+Period { expel-window-from-column; }

      Mod+R { switch-preset-column-width; }

      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }

      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }

      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }

      Mod+V { toggle-window-floating; }
      Mod+Shift+V { switch-focus-between-floating-and-tiling; }

      Mod+S { screenshot; }

      Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
    }
  '';
}
