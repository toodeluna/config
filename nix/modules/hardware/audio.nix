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

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      extraConfig.pipewire."10-quantum" = {
        "context.properties"."default.clock.min-quantum" = 1024;
      };

      configPackages = [
        pkgs.custom.pipewire-rnnoise
      ];
    };
  };
}
