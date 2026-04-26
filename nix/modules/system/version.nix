{
  class,
  lib,
  self,
  ...
}:
let
  versions = {
    nixos = "26.05";
    darwin = 6;
  };
in
{
  system = {
    stateVersion = lib.getAttr class versions;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}
