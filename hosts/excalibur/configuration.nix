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
    "ghostty"
    "google-chrome"
    "microsoft-outlook"
    "microsoft-teams"
    "spotify"
    "zen"
  ];

  environment = {
    systemPackages = [
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
