{ inputs, self, ... }:
{
  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    self.overlays.default
    inputs.firefox-addons.overlays.default
  ];
}
