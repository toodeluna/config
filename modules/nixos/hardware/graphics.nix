{ lib, config, ... }:
{
  options.soul.hardware.graphics = {
    enable = lib.mkEnableOption "graphics";
  };

  config.hardware.graphics = lib.mkIf config.soul.hardware.graphics.enable {
    enable = true;
    enable32Bit = true;
  };
}
