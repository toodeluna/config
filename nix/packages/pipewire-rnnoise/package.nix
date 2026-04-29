{
  lib,
  writeTextDir,

  rnnoise-plugin,

  priority ? 99,
  vadThreshold ? 95,
  vadGracePeriod ? 200,
  vadGracePeriodRetroactive ? 0,
}:
let
  path = "share/pipewire/pipewire.conf.d/${toString priority}-rnnoise.conf";
  package = writeTextDir path (builtins.toJSON config);

  config = {
    "context.modules" = lib.singleton {
      name = "libpipewire-module-filter-chain";

      args = {
        "node.description" = "Noise cancelling source";
        "media.name" = "Noise cancelling source";

        "filter.graph".nodes = lib.singleton {
          type = "ladspa";
          name = "rnnoise";
          label = "noise_suppressor_mono";
          plugin = "${rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";

          control = {
            "VAD Threshold (%)" = vadThreshold;
            "VAD Grace Period (ms)" = vadGracePeriod;
            "Retroactive VAD Grace (ms)" = vadGracePeriodRetroactive;
          };
        };

        "capture.props" = {
          "node.name" = "capture.rnnoise_source";
          "audio.rate" = 48000;
        };

        "playback.props" = {
          "node.name" = "rnnoise_source";
          "media.class" = "Audio/Source";
          "audio.rate" = 48000;
        };
      };
    };
  };

  meta = {
    description = "A noise cancelling plugin configuration for pipewire";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.toodeluna ];
  };
in
package // { inherit meta; }
