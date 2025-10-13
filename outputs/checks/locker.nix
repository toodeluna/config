{ self, ... }:
{
  perSystem =
    { pkgs, inputs', ... }:
    {
      checks.locker =
        pkgs.runCommandNoCCLocal "locker-check"
          {
            meta.description = "Check for duplicate entries in lockfile";
            nativeBuildInputs = [ inputs'.locker.packages.default ];
          }
          ''
            cd "${self}"
            locker
            touch "$out"
          '';
    };
}
