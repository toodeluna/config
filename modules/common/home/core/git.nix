{ pkgs, osConfig, config, ... }:
{
  programs.git = {
    enable = true;
    userName = osConfig.custom.profile.name;
    userEmail = osConfig.custom.profile.email;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };

    aliases = {
      lga = "log --all --decorate --graph --oneline";
      put = "push --set-upstream";
      amend = "commit --amend";
      ui = "!${pkgs.lazygit}/bin/lazygit";
    };

    extraConfig = {
      core.ignorecase = false;
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}
