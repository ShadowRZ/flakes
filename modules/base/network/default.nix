{
  flake.modules.nixos = {
    base = {
      networking = {
        # Disable global DHCP
        useDHCP = false;
        # Enable NAT
        nat.enable = true;
        # Predictable interfaces
        usePredictableInterfaceNames = true;

        stevenblack.enable = true;

        nftables = {
          enable = true;
        };

        firewall = {
          enable = true;
          allowPing = true;
          trustedInterfaces = [ "virbr0" ];
        };
      };

      services.resolved.enable = true;

      ### https://wiki.archlinux.org/title/Sysctl#Improving_performance
      boot.kernelModules = [ "tcp_bbr" ];
      boot.kernel.sysctl = {
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";
      };
    };
  };
}
