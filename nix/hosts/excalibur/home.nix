{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  programs.vesktop.enable = true;
  programs.opencode.enable = true;
  programs.nix-your-shell.enable = true;
  programs.carapace.enable = true;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    sources.palette = inputs.catppuccin-palette;
    mpv.enable = false;
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

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    settings = {
      window-title-font-family = "Work Sans";
      font-family = "JetBrainsMono Nerd Font";
      font-feature = "-calt, -liga, -dlig";
      font-size = 14;

      cursor-style = "underline";
      shell-integration-features = "no-cursor";

      background-opacity = 0.85;
      background-blur = "macos-glass-regular";
    };
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

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      name = "Default";
      isDefault = true;

      settings = {
        "extensions.autoDisableScopes" = false;
        "general.autoScroll" = true;
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
          pkgs.firefox-addons.ublock-origin
          pkgs.firefox-addons.yomitan
          pkgs.firefox-addons.youtube-shorts-block
        ];
      };
    };
  };
}
