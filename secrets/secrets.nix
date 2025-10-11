let
  keys = import ../config/ssh-keys.nix;
in
{
  "password.age".publicKeys = [
    keys.crona.luna
    keys.crona.root
  ];
}
