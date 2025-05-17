{ lib, ... }:
{
  options.custom.modules.gaming.enable = lib.mkEnableOption "the gaming module";
}
