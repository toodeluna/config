with import ./keys.nix;
{
  "blackstar/password.age".publicKeys = [
    blackstar.root
    blackstar.luna
  ];

  "blackstar/anki/luna.age".publicKeys = [
    blackstar.root
    blackstar.luna
  ];

  "crona/password.age".publicKeys = [
    crona.root
    crona.luna
  ];

  "crona/anki/key.age".publicKeys = [
    crona.root
    crona.luna
  ];
}
