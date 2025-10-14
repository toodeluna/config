{
  pkgs,
  self,
  inputs,
  config,
  lib,
  ...
}:
{
  soul.theme = {
    wallpaper = "${self}/assets/wallpapers/yamada-ryo.png";
  };

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
