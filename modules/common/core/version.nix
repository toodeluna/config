{ self, pkgs, ... }:
let
  version = self.lib.conditional pkgs {
    linux = "25.05";
    darwin = 6;
  };
in
{
  system = {
    stateVersion = version;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}
