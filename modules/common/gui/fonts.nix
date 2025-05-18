{
  pkgs,
  lib,
  config,
  ...
}:
{
  fonts.packages = lib.mkIf config.custom.modules.gui.enable [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.jetbrains-mono

    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji

    pkgs.work-sans
    pkgs.source-sans
    pkgs.source-serif
  ];
}
