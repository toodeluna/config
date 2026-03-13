{ inputs, ... }:
{
  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.firefox-addons.overlays.default
  ];
}
