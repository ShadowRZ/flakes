{
  flake.modules.nixos = {
    "hosts/mimeow-coffees" =
      { pkgs, ... }:
      {
        virtualisation = {
          # Libvirtd
          libvirtd = {
            enable = true;
            qemu = {
              package = pkgs.qemu_kvm;
              # Don't run as root
              runAsRoot = false;
              # Enable virtual TPM support
              swtpm.enable = true;
              vhostUserPackages = [ pkgs.virtiofsd ];
            };
          };
          spiceUSBRedirection.enable = true;
          # For Dev Containers
          containers = {
            enable = true;
          };
          # Waydroid
          waydroid = {
            enable = true;
            package = pkgs.waydroid-nftables;
          };
        };

        # Users
        users.users.shadowrz.extraGroups = [ "libvirtd" ];

        services.pykms.enable = true;

        programs.virt-manager.enable = true;
      };
  };
}
