{
  services.resolved.enable = true;

  ### https://wiki.archlinux.org/title/Sysctl#Improving_performance
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
