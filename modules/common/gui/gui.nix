{ pkgs, lib, ... }:
{
  options.soul.gui.enable = lib.mkEnableOption "the graphical user interface" // {
    default = true;
    readOnly = pkgs.stdenv.hostPlatform.isDarwin;
  };
}
