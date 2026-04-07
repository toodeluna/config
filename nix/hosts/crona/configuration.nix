{
  inputs',
  inputs,
  pkgs,
  self,
  ...
}:
{
  programs.gamemode.enable = true;

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
      inputs.mangowm.hmModules.mango
      inputs.nixvim.homeModules.default
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

    extraGroups = [
      "wheel"
      "video"
      "audio"
      "gamemode"
    ];
  };

  programs.mango = {
    enable = true;
    package = inputs'.mangowm.packages.mango.override { enableXWayland = false; };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  home-manager.users = {
    luna = ./home.nix;
  };
}
