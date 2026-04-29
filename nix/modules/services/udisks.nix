{ mkNixosModule, ... }:
mkNixosModule {
  services.udisks2.enable = true;
}
