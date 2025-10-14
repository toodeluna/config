{ lib, config, ... }:
let
  inherit (config.soul.gui) fonts;
in
{
  fonts.fontconfig.defaultFonts = lib.mkIf config.soul.gui.enable {
    emoji = [ fonts.emoji.name ];
    monospace = [ fonts.monospace.name ];
    sansSerif = [ fonts.sans.name ];
    serif = [ fonts.serif.name ];
  };
}
