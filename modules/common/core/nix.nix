{ pkgs, ... }:
let
  sudoersGroup = if pkgs.stdenv.hostPlatform.isLinux then "@wheel" else "@admin";
in
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      trusted-users = [ sudoersGroup ];
      allowed-users = [ sudoersGroup ];

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowAliases = false;
  };
}
