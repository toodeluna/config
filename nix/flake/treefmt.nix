{ inputs, lib, ... }:
{
  imports = [ inputs.treefmt.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          just.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          shellcheck.enable = true;
          shfmt.enable = true;
        };

        settings.formatter.qmlformat = {
          command = lib.getExe' pkgs.kdePackages.qtdeclarative "qmlformat";
          options = [ "-i" ];
          includes = [ "*.qml" ];
        };
      };
    };
}
