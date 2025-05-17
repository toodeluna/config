{
  disko.devices.disk = {
    nvme1n1 = {
      type = "disk";
      device = "/dev/nvme1n1";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            type = "EF00";
            size = "1G";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=077" ];
            };
          };

          swap = {
            size = "64G";

            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };

          root = {
            size = "100%";

            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };

    nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";

      content = {
        type = "gpt";

        partitions.home = {
          type = "8302";
          size = "100%";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
