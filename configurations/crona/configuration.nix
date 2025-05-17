{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git.enable = true;
  programs.neovim.enable = true;
  services.openssh.enable = true;
}
