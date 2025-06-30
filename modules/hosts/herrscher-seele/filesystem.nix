{ inputs, ... }:
{
  flake.modules.nixos = {
    "hosts/herrscher-seele" = {
      imports = [
        inputs.disko.nixosModules.disko
      ];

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
                  end = "100%";
                  content = {
                    type = "luks";
                    name = "crypted";
                    settings = {
                      allowDiscards = true;
                      bypassWorkqueues = true;
                      crypttabExtraOpts = [
                        "same-cpu-crypt"
                        "submit-from-crypt-cpus"
                        "tpm2-measure-pcr=yes"
                        "fido2-device=auto"
                        "tpm2-device=auto"
                      ];
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
                        "/@swap" = {
                          mountpoint = "/.swapvol";
                          swap = {
                            swapfile.size = "16G";
                          };
                        };
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
    };
  };
}
