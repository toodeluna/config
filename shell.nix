{
  mkShell,
  agenix,
  lix,
  mkpasswd,
}:
let
  agenixWithLix = agenix.override { nix = lix; };
in
mkShell {
  packages = [
    agenixWithLix
    lix
    mkpasswd
  ];
}
