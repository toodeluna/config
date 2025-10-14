{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.soul.hardware.audio = {
    enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf config.soul.hardware.audio.enable {
    security.rtkit.enable = true;
    environment.systemPackages = [ pkgs.pulsemixer ];

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
