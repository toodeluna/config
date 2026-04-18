{ self, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = lib.packagesFromDirectoryRecursive {
        inherit (pkgs) callPackage;
        directory = "${self}/nix/packages";
      };
    };
}
