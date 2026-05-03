with import ./keys.nix;
{
  "blackstar/password.age".publicKeys = [
    blackstar.root
    blackstar.luna
  ];

  "crona/password.age".publicKeys = [
    crona.root
    crona.luna
  ];
}
