{ config, pkgs, lib, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  programs.home-manager.enable = true;
  programs.neovim.enable = true;

  home = {
    stateVersion = "26.05";
    preferXdgDirectories = true;
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
}
