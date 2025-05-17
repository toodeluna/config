{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  programs.zen-browser = lib.mkIf osConfig.custom.modules.gui.enable {
    enable = true;
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (lib.mkForce null);

    profiles.main = {
      isDefault = true;
      name = "Luna";

      settings = {
        "zen.urlbar.replace-newtab" = false;
        "zen.view.experimental-rounded-view" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
      };

      extensions = {
        force = true;

        packages = with pkgs.firefox-addons; [
          proton-pass
          ublock-origin
          youtube-shorts-block
          shinigami-eyes
        ];
      };
    };
  };
}
