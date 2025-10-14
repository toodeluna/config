{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  inherit (osConfig.soul) gui;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  config = lib.mkIf (isLinux && gui.enable) {
    dconf.settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    gtk = {
      enable = true;

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };
  };
}
