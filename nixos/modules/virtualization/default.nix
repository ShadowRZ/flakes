{ pkgs, ... }: {
  # Libvirtd
  virtualisation = {
    waydroid.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        # Enable UEFI
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        # Enable virtual TPM support
        swtpm.enable = true;
      };
    };
  };
  # Libvirt tools
  environment.systemPackages = with pkgs; [ virt-viewer virt-manager ];
}
