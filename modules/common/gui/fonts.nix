{
  pkgs,
  lib,
  config,
  ...
}:
{
  fonts.packages = lib.mkIf config.custom.modules.gui.enable [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.jetbrains-mono
    pkgs.work-sans
  ];
}
