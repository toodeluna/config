with import ./keys.nix;
{
  "crona/password.age".publicKeys = [
    crona.root
    crona.luna
  ];

  "blackstar/password.age".publicKeys = [
    blackstar.root
    blackstar.luna
  ];
}
