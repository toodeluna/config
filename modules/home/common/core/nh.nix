{ pkgs, config, ... }:
let
  githubRoot = if pkgs.stdenv.hostPlatform.isLinux then "github" else "GitHub";
in
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "${config.home.homeDirectory}/${githubRoot}/toodeluna/config";
  };
}
