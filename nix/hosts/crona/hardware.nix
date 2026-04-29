{
  networking.useDHCP = true;
  networking.interfaces.enp6s0.useDHCP = true;

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];
}
