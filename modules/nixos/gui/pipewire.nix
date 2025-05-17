{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.custom.modules.gui.enable {
    security.rtkit.enable = true;
    environment.systemPackages = [ pkgs.pulsemixer ];

    services.pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
