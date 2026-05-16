{ inputs, ... }:
let
  config = {
    allowAliases = false;
    allowDeprecatedx86_64Darwin = true;
    allowUnfree = true;
  };

  overlays = [
    inputs.agenix.overlays.default
    inputs.firefox-addons.overlays.default
    inputs.lix-module.overlays.default
    inputs.quoteit.overlays.default
    inputs.self.overlays.default
    inputs.tgirlpkgs.overlays.default
  ];
in
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs { inherit system config overlays; };
    };
}
