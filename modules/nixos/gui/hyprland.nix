{ lib, config, ... }:
{
  programs.hyprland = lib.mkIf config.custom.modules.gui.enable {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
