{ lib, pkgs, config, ... }: {
  services.smartdns = {
    enable = true;
    settings = with pkgs; {
      conf-file = [
        "${./configs/accelerated-domains.china.smartdns.conf}"
        "${./configs/apple.china.smartdns.conf}"
        "${./configs/google.china.smartdns.conf}"
        "${./configs/bogus-nxdomain.china.smartdns.conf}"
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
    # pykms
    pykms = {
      enable = true;
    };
  };

  networking = {
    # Use NetworkManager
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      extraConfig = ''
        [keyfile]
        path = /var/lib/NetworkManager/system-connections
        [connectivity]
        uri = http://google.cn/generate_204
        response =
      '';
      unmanaged = [ "interface-name:virbr*" "lo" ];
      firewallBackend = "nftables";
    };
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
      allowPing = true;
      interfaces = {
        # virbr0: Allow passthrough of KMS packets
        "virbr0" = {
          allowedTCPPorts = [ config.services.pykms.port ];
          allowedUDPPorts = [ config.services.pykms.port ];
        };
      };
    };
    # Enable NAT
    nat = { enable = true; };
    # Predictable interfaces
    usePredictableInterfaceNames = true;
    # Set smartdns server
    nameservers = [ "127.0.53.53" ];
    # Use nftables
    nftables = {
      enable = true;
    };
  };

  services = {
    resolved = {
      enable = true;
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
