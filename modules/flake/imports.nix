{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
    inputs.easy-hosts.flakeModule
    inputs.flake-parts.flakeModules.modules
    inputs.treefmt.flakeModule
  ];
}
