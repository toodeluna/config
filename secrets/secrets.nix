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

  "blackstar/anki/luna.age".publicKeys = [
    blackstar.root
    blackstar.luna
  ];

  "blackstar/yamtrack/secret.age".publicKeys = [
    blackstar.root
    blackstar.luna
  ];
}
