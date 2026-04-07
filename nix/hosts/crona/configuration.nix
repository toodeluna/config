{
  inputs,
  pkgs,
  self,
  ...
}:
{
  system = {
    stateVersion = "26.05";
    configurationRevision = self.rev or self.dirtRev or null;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";

    extraSpecialArgs = {
      inherit self inputs;
    };

    sharedModules = [
      inputs.catppuccin.homeModules.default
      inputs.tgirlpkgs.homeModules.default
    ];
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  catppuccin.sources = {
    palette = inputs.catppuccin-palette;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    extraGroups = [ "wheel" ];
  };

  home-manager.users = {
    luna = ./home.nix;
  };
}
