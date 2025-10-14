{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (osConfig.soul) gui;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  programs.rofi = lib.mkIf (isLinux && gui.enable) {
    enable = true;
  };
}
