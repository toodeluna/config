{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = lib.mkIf config.soul.gui.enable [ pkgs.raycast ];
}
