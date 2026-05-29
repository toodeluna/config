{
  config,
  inputs,
  lib,
  self,
  ...
}:
{
  options.soul.system.home = lib.mkOption {
    default = { };
    description = "Home manager configuration shared between all users.";
    type = lib.types.deferredModule;
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "home-manager-backup";

      extraSpecialArgs = {
        inherit self inputs;
      };

      sharedModules = [
        config.soul.system.home
        inputs.agenix.homeManagerModules.default
        inputs.catppuccin.homeModules.default
        inputs.extersia-pkgs.homeModules.default
        inputs.nixvim.homeModules.default
        inputs.zen-browser.homeModules.default
      ];
    };

    soul.system.home = {
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };
}
