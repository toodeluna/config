{ pkgs, ... }:
{
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;
  users.users.profile.shell = pkgs.zsh;
}
