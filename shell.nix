{
  mkShell,
  agenix,
  caligula,
  lix,
  mkpasswd,
}:
let
  agenixWithLix = agenix.override { nix = lix; };
in
mkShell {
  packages = [
    agenixWithLix
    caligula
    lix
    mkpasswd
  ];
}
