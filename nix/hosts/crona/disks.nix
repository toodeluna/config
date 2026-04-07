{
  disko.devices.disk.nvme0n1 = {
    device = "/dev/nvme0n1";
    type = "disk";

    content = {
      type = "gpt";

      partitions.nix = {
        size = "100%";

        content = {
          type = "filesystem";
          format = "btrfs";
          mountpoint = "/nix";
        };
      };
    };
  };

  disko.devices.disk.nvme1n1 = {
    device = "/dev/nvme1n1";
    type = "disk";

    content = {
      type = "gpt";

      partitions.esp = {
        size = "1G";
        type = "EF00";

        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [ "umask=0077" ];
        };
      };

      partitions.root = {
        end = "-64G";

        content = {
          type = "filesystem";
          format = "btrfs";
          mountpoint = "/";
        };
      };

      partitions.swap = {
        size = "100%";

        content = {
          type = "swap";
          discardPolicy = "both";
          resumeDevice = true;
        };
      };
    };
  };

  disko.devices.disk.nvme2n1 = {
    device = "/dev/nvme2n1";
    type = "disk";

    content = {
      type = "gpt";

      partitions.home = {
        size = "100%";
        type = "8300";

        content = {
          type = "filesystem";
          format = "btrfs";
          mountpoint = "/home";
        };
      };
    };
  };
}
