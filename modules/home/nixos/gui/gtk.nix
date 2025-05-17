{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  gtk = lib.mkIf osConfig.custom.modules.gui.enable {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
