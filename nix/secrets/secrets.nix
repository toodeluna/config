with import ./keys.nix;
{
  "crona/password.age".publicKeys = [
    crona.root
    crona.luna
  ];
}
