{ self, inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";

    extraSpecialArgs = {
      inherit self inputs;
    };

    sharedModules = [
      "${self}/modules/home"
      inputs.zen-browser.homeModules.default
    ];
  };
}
