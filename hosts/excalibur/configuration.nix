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
      pkgs.raycast
      pkgs.vscode
    ];
  };
}
