{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.soul.gui) fonts;

  mkFontOption = name: default: {
    name = lib.mkOption {
      description = "The name of the ${name} font.";
      type = lib.types.str;
      default = default.name;
    };

    package = lib.mkOption {
      description = "The ${name} font package.";
      type = lib.types.package;
      default = default.package;
    };
  };
in
{
  options.soul.gui.fonts = {
    monospace = mkFontOption "monospace" {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };

    sans = mkFontOption "sans-serif" {
      name = "Work Sans";
      package = pkgs.work-sans;
    };

    serif = mkFontOption "serif" {
      name = "Noto Serif";
      package = pkgs.noto-fonts;
    };

    emoji = mkFontOption "emoji" {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };

    extraPackages = lib.mkOption {
      description = "Extra fonts to install.";
      type = lib.types.listOf lib.types.package;

      default = [
        pkgs.noto-fonts-cjk-sans
        pkgs.noto-fonts-cjk-serif
      ];
    };
  };

  config.fonts = lib.mkIf config.soul.gui.enable {
    packages = fonts.extraPackages ++ [
      fonts.emoji.package
      fonts.monospace.package
      fonts.sans.package
      fonts.serif.package
    ];
  };
}
