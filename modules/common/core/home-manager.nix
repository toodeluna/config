{
  self,
  config,
  inputs,
  inputs',
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs'; };

    users.profile.imports = [
      inputs.catppuccin.homeModules.default
      inputs.zen-browser.homeModules.default
      "${self}/modules/home/common"
    ];
  };
}
