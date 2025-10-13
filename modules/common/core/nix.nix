{ self, pkgs, ... }:
let
  sudoers = self.lib.conditional pkgs {
    linux = [ "@wheel" ];
    darwin = [ "@admin" ];
  };
in
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      trusted-users = sudoers;
      allowed-users = sudoers;

      experimental-features = [
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];
    };
  };
}
