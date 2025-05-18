{ pkgs, ... }:
{
  homebrew.casks = [
    "ghostty"
    "stremio"
    "zen"
  ];

  environment.systemPackages = [
    pkgs.raycast
  ];
}
