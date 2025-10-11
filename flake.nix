{
  description = "My system configurations in a Nix flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.treefmt.flakeModule ];

      perSystem.treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          nixfmt.enable = true;
          prettier.enable = true;
        };
      };
    };
}
