{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.agenix.overlays.default
  ];
}
