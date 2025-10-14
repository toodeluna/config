{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowAliases = false;
      allowUnfree = true;
    };

    overlays = [
      inputs.firefox-addons.overlays.default
    ];
  };
}
