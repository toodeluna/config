{
  self,
  inputs,
  lib,
  ...
}:
let
  modules = {
    shared = [
      "${self}/nix/modules"
    ];

    nixos = [
      inputs.agenix.nixosModules.default
      inputs.catppuccin.nixosModules.default
      inputs.disko.nixosModules.default
      inputs.extersia-pkgs.nixosModules.default
      inputs.home-manager.nixosModules.default
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      inputs.tangled.nixosModules.knot
      inputs.topology.nixosModules.default
    ];

    darwin = [
      inputs.agenix.darwinModules.default
      inputs.extersia-pkgs.darwinModules.default
      inputs.home-manager.darwinModules.default
      inputs.homebrew.darwinModules.default
      inputs.oomf-time.darwinModules.default
    ];
  };

  mkHelpers = class: rec {
    mkNixosModule = module: mkModule { nixos = module; };
    mkDarwinModule = module: mkModule { darwin = module; };

    mkModule =
      {
        shared ? { },
        nixos ? { },
        darwin ? { },
      }:
      {
        imports = lib.flatten [
          (lib.singleton shared)
          (lib.optional (class == "nixos") nixos)
          (lib.optional (class == "darwin") darwin)
        ];
      };
  };
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    useGlobalPkgs = true;

    hosts.blackstar = {
      path = "${self}/nix/hosts/blackstar";
      class = "nixos";
      arch = "x86_64";
    };

    hosts.crona = {
      path = "${self}/nix/hosts/crona";
      class = "nixos";
      arch = "x86_64";
    };

    hosts.excalibur = {
      path = "${self}/nix/hosts/excalibur";
      class = "darwin";
      arch = "aarch64";
    };

    hosts.tsubaki = {
      path = "${self}/nix/hosts/tsubaki";
      class = "nixos";
      arch = "x86_64";
    };

    shared = {
      specialArgs = { inherit self inputs; };
      modules = modules.shared;
    };

    perClass = class: {
      modules = lib.getAttr class modules;

      specialArgs = {
        inherit class;
        inherit (mkHelpers class) mkModule mkNixosModule mkDarwinModule;
        keys = import "${self}/nix/secrets/keys.nix";
      };
    };
  };
}
