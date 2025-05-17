{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "crona";
  time.timeZone = "Europe/Brussels";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    useXkbConfig = true;
  };

  programs.git.enable = true;
  programs.neovim.enable = true;
  services.openssh.enable = true;
}
