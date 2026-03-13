{ pkgs, lib, ... }:
{
  environment.shells = [ pkgs.nushell ];
  programs.bash.interactiveShellInit = ''exec "${lib.getExe pkgs.nushell}"'';
}
