let
  keys = import ./ssh-keys.nix;
in
{
  "password.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];
}
