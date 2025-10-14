{
  pkgs,
  self,
  inputs,
  config,
  lib,
  ...
}:
{
  soul.casks = [
    "google-chrome"
    "microsoft-outlook"
    "microsoft-teams"
    "spotify"
    "zen"
  ];

  users = {
    users.profile = {
      shell = pkgs.zsh;
    };
  };

  environment = {
    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];

    systemPackages = [
      pkgs.ghostty-bin
      pkgs.git
      pkgs.lazygit
      pkgs.neovim
      pkgs.nh
      pkgs.raycast
      pkgs.vscode
    ];
  };

  programs = {
    zsh.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.work-sans
  ];
}
