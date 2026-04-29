{
  config,
  mkNixosModule,
  ...
}:
let
  inherit (config.soul.hardware.amdgpu) enable;
in
mkNixosModule {
  hardware.graphics = {
    inherit enable;
    enable32Bit = enable;
  };
}
