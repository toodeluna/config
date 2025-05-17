{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.greetd = lib.mkIf config.custom.modules.gui.enable {
    enable = true;

    settings.default_session.command = ''
      ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --cmd "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop" \
        --asterisks \
        --theme "border=magenta;text=white;prompt=green;time=red;action=blue;button=blue;container=black;input=white" \
        --greeting "Hello there!"
    '';
  };
}
