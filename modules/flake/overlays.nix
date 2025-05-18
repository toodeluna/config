{ self, ... }:
{
  flake.overlays.default =
    final: prev:
    if builtins.hasAttr prev.stdenv.hostPlatform.system self.packages then
      self.packages.${prev.stdenv.hostPlatform.system}
    else
      { };
}
