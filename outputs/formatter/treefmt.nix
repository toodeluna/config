{
  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      nixfmt.enable = true;
      prettier.enable = true;
    };
  };
}
