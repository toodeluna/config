{
  description = "My system configurations in a Nix flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";

    locker = {
      url = "github:tgirlcloud/locker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      outputsModule = inputs.import-tree ./outputs;
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.treefmt.flakeModule
        outputsModule
      ];
    };
}
