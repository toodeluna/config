{
  self,
  config,
  pkgs,
  ...
}:
let
  githubDirectory = self.lib.conditional pkgs {
    linux = "github";
    darwin = "GitHub";
  };
in
{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/${githubDirectory}/toodeluna/config";
    clean.enable = true;
  };
}
