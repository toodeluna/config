{
  flake.modules.generic.base.nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      warn-dirty = false;
      use-xdg-base-directories = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  flake.modules.darwin.base.nix.settings = rec {
    trusted-users = [ "@admin" ];
    allowed-users = trusted-users;
  };

  flake.modules.nixos.base.nix.settings = rec {
    trusted-users = [ "@wheel" ];
    allowed-users = trusted-users;
  };
}
