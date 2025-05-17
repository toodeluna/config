{ self, config, inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.profile.imports = [
      inputs.catppuccin.homeModules.default
      "${self}/modules/common/home"
    ];
  };
}
