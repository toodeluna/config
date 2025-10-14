{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  inherit (osConfig.soul) profile;
  addons = pkgs.firefox-addons;
in
{
  programs.zen-browser = lib.mkIf osConfig.soul.gui.enable {
    enable = true;
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;

    profiles.primary = {
      isDefault = true;
      name = profile.name;

      settings = {
        "zen.urlbar.replace-newtab" = false;
        "zen.view.experimental-rounded-view" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
        "zen.workspaces.open-new-tab-if-last-unpinned-tab-is-closed" = true;
      };

      extensions = {
        force = true;

        packages = [
          addons.proton-pass
          addons.return-youtube-dislikes
          addons.shinigami-eyes
          addons.sponsorblock
          addons.ublock-origin
          addons.yomitan
          addons.youtube-shorts-block
        ];
      };
    };
  };
}
