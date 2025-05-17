{ self, config, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.profile.imports = [ "${self}/modules/common/home" ];
  };
}
