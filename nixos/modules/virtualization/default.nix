{ pkgs, ... }: {
  # QEMU
  environment.systemPackages = with pkgs; [
    qemu
    qemu-utils
  ];
}
