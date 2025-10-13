{
  disko.devices.disk.primary = {
    device = "/dev/nvme1n1";
    type = "disk";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          size = "500M";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        root = {
          end = "-32GB";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };

        swap = {
          size = "100%";

          content = {
            type = "swap";
            discardPolicy = "both";
            resumeDevice = true;
          };
        };
      };
    };
  };

  disko.devices.disk.secondary = {
    device = "/dev/nvme0n1";
    type = "disk";

    content = {
      type = "gpt";

      partitions.home = {
        size = "100%";
        type = "8300";

        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/home";
        };
      };
    };
  };
}
