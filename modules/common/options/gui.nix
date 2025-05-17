{ lib, pkgs, ... }:
{
  options.custom.modules.gui.enable = lib.mkEnableOption "the gui module" // {
    default = true;
    readOnly = pkgs.stdenv.hostPlatform.isDarwin;
  };
}
