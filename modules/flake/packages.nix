{ self, ... }:
{
  perSystem =
    { inputs', ... }:
    {
      packages.bnuyvim = inputs'.nixvim.legacyPackages.makeNixvim self.nixvimModules.default;
    };
}
