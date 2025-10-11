{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
    inputs.easy-hosts.flakeModule
    inputs.treefmt.flakeModule
  ];
}
