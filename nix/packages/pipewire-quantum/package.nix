{
  lib,
  writeTextDir,

  priority ? 10,
  quantum ? 1024,
}:
let
  path = "share/pipewire/pipewire.conf.d/${toString priority}-quantum.conf";
  package = writeTextDir path (builtins.toJSON config);

  config = {
    "context.properties"."default.clock.min-quantum" = quantum;
  };

  meta = {
    description = "A quantum plugin for pipewire";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.toodeluna ];
  };
in
package // { inherit meta; }
