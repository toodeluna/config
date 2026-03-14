{ lib, ... }:
let
  types = [
    "desktop"
    "iso"
    "laptop"
    "server"
  ];
in
{
  options.soul.system = {
    type = lib.mkOption {
      description = "The type of system.";
      example = "desktop";
      type = lib.types.enum types;
    };
  };
}
