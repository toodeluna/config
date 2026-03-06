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
    { inputs', pkgs, ... }:
    {
      checks.locker = pkgs.runCommand "locker-check" {
        meta.description = "Check for duplicate lockfile entries";
        nativeBuildInputs = [ inputs'.tgirlpkgs.packages.locker ];
      } script;
    };
}
