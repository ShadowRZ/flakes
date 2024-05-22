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
              end = "-8G";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = [ "fido2-device=auto" ];
                };
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
            swap = {
              size = "100%";
              content = {
                type = "swap";
                # discardPolicy = "both"; TODO
                resumeDevice = true; # resume from hiberation from this device
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

