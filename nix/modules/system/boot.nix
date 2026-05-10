{
  config,
  lib,
  mkNixosModule,
  pkgs,
  ...
}:
let
  cfg = config.soul.system.boot;
  quiet = cfg.quiet || cfg.splash;

  loaders = [
    "systemd-boot"
    "grub"
  ];
in
mkNixosModule {
  options.soul.system.boot = {
    loader = lib.mkOption {
      default = "systemd-boot";
      description = "The boot loader to use.";
      type = lib.types.enum loaders;
    };

    limit = lib.mkOption {
      default = 10;
      description = "The amount of configurations to show on the boot screen.";
      type = lib.types.ints.unsigned;
    };

    quiet = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Whether to enable quiet boot.";
    };

    splash = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Whether to show the custom splash screen on boot.";
    };
  };

  config.boot = {
    consoleLogLevel = lib.mkIf quiet 3;
    initrd.verbose = !quiet;

    loader = {
      timeout = lib.mkIf quiet 0;
      efi.canTouchEfiVariables = cfg.loader == "systemd-boot";
    };

    loader.grub = {
      enable = cfg.loader == "grub";
      configurationLimit = cfg.limit;
      efiInstallAsRemovable = true;
      efiSupport = true;
    };

    loader.systemd-boot = {
      enable = cfg.loader == "systemd-boot";
      configurationLimit = cfg.limit;
    };

    plymouth = {
      enable = cfg.splash;
      theme = pkgs.custom.plymouth-gif-theme.pname;
      themePackages = [ pkgs.custom.plymouth-gif-theme ];
    };

    kernelParams = lib.mkIf quiet [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
  };
}
