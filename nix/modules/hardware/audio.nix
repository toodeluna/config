{
  config,
  lib,
  mkNixosModule,
  pkgs,
  ...
}:
let
  cfg = config.soul.hardware.audio;
in
mkNixosModule {
  options.soul.hardware.audio = {
    enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf cfg.enable {
    soul.system.packages = {
      inherit (pkgs) wiremix;
    };

    security.rtkit = {
      enable = true;
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      configPackages = [
        pkgs.custom.pipewire-quantum
        pkgs.custom.pipewire-rnnoise
      ];
    };
  };
}
