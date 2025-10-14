{ config, osConfig, ... }:
let
  inherit (osConfig.soul) profile;
in
{
  programs.git = {
    enable = true;
    userName = profile.name;
    userEmail = profile.email;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };

    aliases = {
      lga = "log --all --decorate --graph --oneline";
      put = "push --set-upstream";
      amend = "commit --amend";
    };

    extraConfig = {
      core.ignorecase = false;
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}
