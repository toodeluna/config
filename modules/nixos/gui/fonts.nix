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
      serif = [ "Noto Fonts CJK Serif" ];
      emoji = [ "Noto Color Emoji" ];

      monospace = [
        "JetBrainsMono Nerd Font"
        "JetBrains Mono"
      ];

      sansSerif = [
        "Work Sans"
        "Noto Fonts CJK Sans"
      ];
    };
  };
}
