{
  lib,
  config,
  pkgs,
  ...
}:
{
  fonts = lib.mkIf config.custom.modules.gui.enable {
    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
      sansSerif = [ "Work Sans" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };
}
