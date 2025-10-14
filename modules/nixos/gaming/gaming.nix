{ lib, config, ... }:
{
  options.soul.gaming = {
    enable = lib.mkEnableOption "gaming software";
  };

  config = lib.mkIf config.soul.gaming.enable {
    programs.gamemode.enable = true;
  };
}
