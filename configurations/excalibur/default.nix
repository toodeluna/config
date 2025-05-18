{ pkgs, ... }:
{
  homebrew.casks = [
    "microsoft-teams"
    "microsoft-outlook"
  ];

  environment.systemPackages = [
    pkgs.vscode
  ];
}
