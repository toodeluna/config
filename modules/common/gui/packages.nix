{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = lib.mkIf config.custom.modules.gui.enable [
    pkgs.discord
    pkgs.spotify
    pkgs.qbittorrent
    pkgs.signal-desktop
  ];
}
