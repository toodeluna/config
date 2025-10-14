{ config, lib, ... }:
let
  inherit (config.soul.boot) loader;
in
{
  options.soul.boot = {
    loader = lib.mkOption {
      description = "The boot loader to use.";
      default = "systemd-boot";

      type = lib.types.enum [
        "grub"
        "systemd-boot"
      ];
    };
  };

  config.boot.loader = {
    grub.enable = loader == "grub";
    systemd-boot.enable = loader == "systemd-boot";
    efi.canTouchEfiVariables = true;
  };
}
