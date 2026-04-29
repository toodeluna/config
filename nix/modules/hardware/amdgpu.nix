{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.hardware.amdgpu;
in
mkNixosModule {
  options.soul.hardware.amdgpu = {
    enable = lib.mkEnableOption "amdgpu";
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}
