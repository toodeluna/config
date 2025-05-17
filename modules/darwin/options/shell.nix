{ lib, pkgs, ... }:
{
  options.users.defaultUserShell = lib.mkOption {
    type = lib.types.package;
    example = pkgs.zsh;
    description = "Stand-in for the NixOS option of the same name.";
  };
}
