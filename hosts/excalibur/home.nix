{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.carapace.enable = true;
  programs.home-manager.enable = true;
  programs.nix-your-shell.enable = true;
  programs.nushell.enable = true;

  home = {
    stateVersion = "25.11";
    preferXdgDirectories = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
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
