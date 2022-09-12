{ lib, pkgs, ... }: {
  services.smartdns = {
    enable = true;
    settings = with pkgs; {
      conf-file = [
        "${smartdns-china-list}/accelerated-domains.china.smartdns.conf"
        "${smartdns-china-list}/apple.china.smartdns.conf"
        "${smartdns-china-list}/google.china.smartdns.conf"
      ];
      bind = [ "127.0.53.53:53" ];
      server-tls = [
        # https://www.dnspod.cn/Products/publicdns
        "1.12.12.12:853 -group china -exclude-default-group"
        "120.53.53.53:853 -group china -exclude-default-group"
        # https://quad9.net/service/service-addresses-and-features/
        "9.9.9.9:853 -tls-host-verify dns.quad9.net"
        "149.112.112.112:853 -tls-host-verify dns.quad9.net"
      ];
      server-https = [
        # https://www.dnspod.cn/Products/publicdns
        "https://doh.pub/dns-query -group china -exclude-default-group -tls-host-verify doh.pub"
        # https://quad9.net/service/service-addresses-and-features/
        "https://9.9.9.9/dns-query -tls-host-verify dns.quad9.net"
        "https://149.112.112.112/dns-query -tls-host-verify dns.quad9.net"
      ];
      # (XXX)
      nameserver = [
        "/github.com/china"
        "/codeload.github.com/china"
        "/ssh.github.com/china"
        "/api.github.com/china"
      ];
      speed-check-mode = "tcp:443,tcp:80";
      # Add log
      log-level = "info";
      log-file = "/var/log/smartdns.log";
    };
  };

  services = {
    # Avahi
    avahi = {
      enable = true;
      nssmdns = true; # mDNS NSS
    };
  };

  networking = {
    # Use systemd-networkd
    useNetworkd = true;
    # Disable global DHCP
    useDHCP = false;
    # Enable firewall
    firewall = {
      enable = true;
      # 5500 is for Clementine
      allowedTCPPorts = [ 22 80 8000 8080 5500 ];
      allowedUDPPorts = [ 53 5500 ];
      # https://userbase.kde.org/KDEConnect
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      extraCommands = ''
        # Accept all ICMP packages.
        iptables -A INPUT -p icmp -j ACCEPT
      '';
    };
    # Enable NAT
    nat = { enable = true; };
    # Predictable interfaces
    usePredictableInterfaceNames = true;
    # Wireless config
    wireless = {
      # Use iwd
      iwd.enable = true;
    };
    # Set smartdns server
    nameservers = [ "127.0.53.53" ];
  };
  systemd.network.links."80-iwd" = lib.mkForce { };

  # Systemd-networkd confiugred interface
  systemd.network = {
    enable = true;
    # Assume it's online when any interface is considered online.
    wait-online.anyInterface = true;
    # Configure systemd-networkd
    config = {
      networkConfig = {
        ManageForeignRoutingPolicyRules = false;
        SpeedMeter = true;
        SpeedMeterIntervalSec = 1;
      };
    };
    # Interfaces
    # For interfaces on the laptop refer to nixos/hardware-configuration.nix
    networks = {
      # Phone
      "20-phone" = {
        # Match RNDIS driver instead
        matchConfig = { Driver = "rndis_host"; };
        DHCP = "yes";
        dhcpV4Config = {
          UseDNS = false;
          RouteMetric = 4096;
        };
        dhcpV6Config = {
          UseDNS = false;
          RouteMetric = 4096;
        };
      };
    };
  };

  services = {
    resolved = {
      # https://www.dnspod.cn/Products/publicdns
      fallbackDns = [ "119.29.29.29" ];
    };
  };

  environment.systemPackages = with pkgs; [
    v2ray
    v2ray-geoip
    v2ray-domain-list-community
  ];
}
