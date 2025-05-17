{ lib, config, ... }:
{
  hardware.graphics = lib.mkIf config.custom.modules.gui.enable {
    enable = true;
    enable32Bit = true;
  };
}
