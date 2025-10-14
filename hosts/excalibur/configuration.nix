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

  environment = {
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

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.work-sans
  ];
}
