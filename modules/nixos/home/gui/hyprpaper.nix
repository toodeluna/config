{ lib, osConfig, ... }:
{
  services.hyprpaper = lib.mkIf osConfig.custom.modules.gui.enable {
    enable = true;

    settings = {
      preload = [ "${osConfig.custom.modules.gui.wallpaper}" ];
      wallpaper = [ ", ${osConfig.custom.modules.gui.wallpaper}" ];
    };
  };
}
