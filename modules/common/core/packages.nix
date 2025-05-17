{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.agenix
    pkgs.sl
    pkgs.cowsay
    pkgs.kittysay
    pkgs.blahaj
  ];
}
