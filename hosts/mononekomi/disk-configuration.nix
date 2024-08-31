{
  disko.devices = {
    disk = {
      rootfs = {
        type = "disk";
        device = "/dev/disk/by-path/pci-0000:06:00.0-nvme-1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            root = {
              end = "-16G";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  # Subvolumes must set a mountpoint in order to be mounted,
                  # unless their parent is mounted
                  subvolumes = {
                    "/@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "defaults"
                        "compress-force=zstd"
                      ];
                    };
                    "/@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "defaults"
                        "compress-force=zstd"
                      ];
                    };
                  };
                };
              };
            };
            "swap" = {
              size = "100%";
              content = {
                type = "luks";
                name = "swap";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=2G"
          "mode=755"
          "nosuid"
          "nodev"
        ];
      };
    };
  };
}
