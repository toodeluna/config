{ self, lib, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    {
      devshells.default = {
        devshell = {
          name = "config";
          motd = "";
        };

        devshell.meta = {
          description = "The development environment for this configuration";
          homepage = "https://github.com/toodeluna/config";
          license = lib.licenses.eupl12;
          platforms = lib.platforms.all;
          maintainers = [ self.lib.maintainers.toodeluna ];
        };

        packagesFrom = [
          self'.formatter
        ];

        packages = [
          pkgs.git
          pkgs.lix
          self'.formatter
        ];
      };
    };
}
