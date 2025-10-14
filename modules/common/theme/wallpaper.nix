{ lib, ... }:
{
  options.soul.theme.wallpaper = lib.mkOption {
    description = "The path to the wallpaper to use.";
    type = lib.types.nullOr lib.types.path;
    default = null;
  };
}
