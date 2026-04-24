{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "config-shell";
        meta.description = "The development environment for this configuration";

        packages = [
          pkgs.agenix
          pkgs.git
          pkgs.just
          pkgs.lix
          pkgs.nh
        ];
      };
    };
}
