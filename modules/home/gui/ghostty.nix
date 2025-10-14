{
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  programs.ghostty = lib.mkIf osConfig.soul.gui.enable {
    enable = true;
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;
  };
}
