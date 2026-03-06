{ self, ... }:
{
  perSystem =
    { self', pkgs, ... }:
    {
      formatter = pkgs.callPackage "${self}/treefmt.nix" { };
    };
}
