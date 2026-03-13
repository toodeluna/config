{ self, pkgs, ... }:
let
  versions = {
    darwin = 6;
    nixos = "26.06";
  };
in
{
  system = {
    stateVersion = if pkgs.stdenv.hostPlatform.isLinux then versions.nixos else versions.darwin;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}
