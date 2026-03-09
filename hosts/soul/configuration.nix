{ self, ... }:
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  services.openssh.enable = true;

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";

  environment.defaultPackages = [ ];
  fonts.enableDefaultPackages = false;

  system = {
    stateVersion = "26.06";
    configurationRevision = self.rev or self.dirtRev or null;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      warn-dirty = false;
      use-xdg-base-directories = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      experimental-features = [
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];
    };
  };

  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };
}
