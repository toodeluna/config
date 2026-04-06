{ self, ... }:
let
  script = ''
    cd "${self}"
    locker
    touch "$out"
  '';
in
{
  perSystem =
    { pkgs, ... }:
    {
      checks.locker = pkgs.runCommand "locker-check" {
        nativeBuildInputs = [ pkgs.locker ];
        meta.description = "Check for duplicate lockfile entries";
      } script;
    };
}
