{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.bnuyvim ];
  environment.variables.EDITOR = "${pkgs.bnuyvim}/bin/nvim";
}
