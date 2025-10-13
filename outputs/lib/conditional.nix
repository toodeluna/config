{
  flake.lib.conditional =
    pkgs:
    { linux, darwin }:
    if pkgs.stdenv.hostPlatform.isLinux then
      linux
    else if pkgs.stdenv.hostPlatform.isDarwin then
      darwin
    else
      throw "unsupported platform detected";
}
