{
  disko.devices = {
    disk = {
      rootfs = {
        type = "disk";
        device = "/dev/disk/by-path/pci-0000:00:10.0-scsi-0:0:0:0";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "300M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "/@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress-force=zstd" ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress-force=zstd" ];
                  };
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
        mountOptions = [ "defaults" "size=2G" "mode=755" "nosuid" "nodev" ];
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}

