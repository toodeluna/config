{ inputs, ... }:
{
  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.self.overlays.default
    inputs.firefox-addons.overlays.default
  ];
}
