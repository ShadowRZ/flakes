{ pkgs, ... }: {

  virtualisation = {
    # Libvirtd
    libvirtd = {
      enable = true;
      qemu = {
        # Full arches
        package = pkgs.qemu;
        # Enable UEFI
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        # Enable virtual TPM support
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true;
    # Podman
    podman = {
      enable = true;
      dockerCompat = true;
    };
    # For Dev Containers
    containers = { enable = true; };
  };

  # Users
  users.users.shadowrz.extraGroups = [ "libvirtd" ];

  services.pykms.enable = true;

  programs.virt-manager.enable = true;
}
