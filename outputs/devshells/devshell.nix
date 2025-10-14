{
  perSystem =
    { pkgs, self', ... }:
    {
      devshells.default = {
        devshell.meta = {
          description = "The development environment for this configuration";
        };

        packages = [
          pkgs.agenix
          pkgs.git
          pkgs.lix
        ];

        packagesFrom = [
          self'.checks.locker
          self'.formatter
        ];
      };
    };
}
