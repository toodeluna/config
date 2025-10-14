{ lib, config, ... }:
{
  homebrew.casks = lib.mkIf config.soul.gui.enable [ "ghostty" ];
}
