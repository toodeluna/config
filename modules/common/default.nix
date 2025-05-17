{
  imports = [
    ./core/home-manager.nix
    ./core/nix.nix
    ./core/overlays.nix
    ./core/packages.nix
    ./core/profile.nix
    ./core/secrets.nix
    ./core/ssh.nix
    ./core/version.nix
    ./core/zsh.nix

    ./gui/fonts.nix

    ./options/gaming.nix
    ./options/gui.nix
  ];
}
