{
  class,
  lib,
  pkgs,
  ...
}:
let
  sudoers = lib.getAttr class {
    nixos = "@wheel";
    darwin = "@admin";
  };
in
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    gc.automatic = pkgs.stdenv.hostPlatform.isDarwin;

    settings = {
      warn-dirty = false;
      use-xdg-base-directories = true;

      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ sudoers ];
      trusted-users = [ sudoers ];

      experimental-features = [
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];

      deprecated-features = [
        "broken-string-indentation"
      ];
    };
  };
}
