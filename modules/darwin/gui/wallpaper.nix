{ lib, config, ... }:
let
  inherit (config.soul) gui;
  inherit (config.soul.theme) wallpaper;
in
{
  system.activationScripts.postActivation.text = lib.mkIf (gui.enable && wallpaper != null) ''
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"${wallpaper}\" as POSIX file"
  '';
}
