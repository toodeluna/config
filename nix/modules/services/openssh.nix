{ mkModule, ... }:
mkModule {
  shared.services.openssh = {
    enable = true;
  };

  nixos.services.openssh.settings = {
    PasswordAuthentication = false;
  };
}
