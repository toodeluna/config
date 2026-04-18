{ withSystem, ... }:
{
  flake.overlays.default = prev: final: {
    custom = withSystem prev.stdenv.hostPlatform.system ({ self', ... }: self'.packages);
  };
}
