{
  self,
  lib,
  pkgs,
  ...
}:
{
  options.custom.modules.gui = {
    enable = lib.mkEnableOption "the gui module" // {
      default = true;
      readOnly = pkgs.stdenv.hostPlatform.isDarwin;
    };

    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "The wallpaper to use.";
      default = "${self}/assets/wallpapers/blossoms.png";
    };
  };
}
