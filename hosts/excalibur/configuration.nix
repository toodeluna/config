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
  ];

  environment = {
    systemPackages = [
      pkgs.lazygit
      pkgs.neovim
      pkgs.vscode
    ];
  };
}
