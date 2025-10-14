{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.profile.shell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];
}
