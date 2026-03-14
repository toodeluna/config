{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf (config.soul.system.type != "server") {
    environment.shells = [ pkgs.nushell ];
    programs.bash.interactiveShellInit = ''exec "${lib.getExe pkgs.nushell}"'';
  };
}
