{ self, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.agenix.overlays.default
    inputs.firefox-addons.overlays.default
    self.overlays.default
  ];
}
