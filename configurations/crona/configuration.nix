{
  config,
  lib,
  pkgs,
  ...
}:
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.git.enable = true;
  programs.neovim.enable = true;
  services.openssh.enable = true;
}
