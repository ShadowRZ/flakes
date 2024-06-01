{lib, ...}: {
  networking.wireless.iwd.enable = lib.mkDefault true;
  services = {
    resolved.enable = true;
    # Avahi
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  systemd.network.links."80-iwd" = lib.mkForce {};

  ### https://wiki.archlinux.org/title/Sysctl#Improving_performance
  boot.kernelModules = ["tcp_bbr"];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
