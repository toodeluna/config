{ lib, osConfig, ... }:
let
  inherit (osConfig.soul) gui;
  inherit (osConfig.soul.theme) wallpaper;
in
{
  services.hyprpaper = lib.mkIf (gui.enable && wallpaper != null) {
    enable = true;

    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };
}
