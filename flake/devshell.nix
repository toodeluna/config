{ self, ... }:
{
  perSystem =
    { inputs', pkgs, ... }:
    {
      devShells.default = pkgs.callPackage "${self}/shell.nix" {
        agenix = inputs'.agenix.packages.default;
        lix = inputs'.lix-module.packages.default;
      };
    };
}
