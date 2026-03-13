{
  mkShell,
  agenix,
  caligula,
  just,
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
    just
    lix
    mkpasswd
  ];
}
