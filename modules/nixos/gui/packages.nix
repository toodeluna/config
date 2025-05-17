{ pkgs, lib, config, ... }:
{
  environment.systemPackages = lib.mkIf config.custom.modules.gui.enable [
    pkgs.stremio
    pkgs.nemo
  ];
}
