{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.agenix
  ];
}
