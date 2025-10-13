{
  perSystem =
    { pkgs, self', ... }:
    {
      devshells.default = {
        devshell.meta = {
          description = "The development environment for this configuration";
        };

        packages = [
          pkgs.lix
          pkgs.git
        ];

        packagesFrom = [
          self'.checks.locker
          self'.formatter
        ];
      };
    };
}
