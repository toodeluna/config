{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
    inputs.treefmt.flakeModule
  ];
}
