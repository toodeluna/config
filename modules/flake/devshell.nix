{ self, lib, ... }:
{
  perSystem =
    {
      inputs',
      pkgs,
      self',
      ...
    }:
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

        devshell.startup.install-git-hooks.text = ''
          cog install-hook --all --overwrite
        '';

        packagesFrom = [
          self'.formatter
        ];

        packages = [
          inputs'.locker.packages.default
          pkgs.cocogitto
          pkgs.git
          pkgs.lix
          self'.formatter
        ];
      };
    };
}
