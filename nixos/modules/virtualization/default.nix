{ pkgs, ... }: {
  # QEMU
  environment.systemPackages = with pkgs; [
    qemu
  ];
}
