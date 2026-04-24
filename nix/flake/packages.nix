{ self, lib, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    let
      packages = lib.packagesFromDirectoryRecursive {
        inherit (pkgs) callPackage;
        directory = "${self}/nix/packages";
      };
    in
    {
      packages = lib.filterAttrs (
        name: package: builtins.elem system (package.meta.platforms or [ ])
      ) packages;
    };
}
