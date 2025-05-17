let
  keys = import ../constants/ssh-keys.nix;
in
{
  "password.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];
}
