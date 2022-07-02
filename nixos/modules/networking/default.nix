{ pkgs, ... }: {
  services.smartdns = {
    enable = true;
    settings = with pkgs; {
      conf-file = [
        "${smartdns-china-list}/accelerated-domains.china.smartdns.conf"
        "${smartdns-china-list}/apple.china.smartdns.conf"
        "${smartdns-china-list}/google.china.smartdns.conf"
      ];
      bind = [ "127.0.0.53:53" ];
      server-tls = [
        "1.12.12.12:853 -group china -exclude-default-group"
        "120.53.53.53:853 -group china -exclude-default-group"
        "9.9.9.9:853 -tls-host-verify dns.quad9.net"
        "149.112.112.112:853 -tls-host-verify dns.quad9.net"
        "1.0.0.1:853 -tls-host-verify cloudflare-dns.com"
      ];
      speed-check-mode = "tcp:443,tcp:80";
    };
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };
  };

  networking.networkmanager = {
    enable = true;
    dns = "none";
    wifi.backend = "iwd";
    extraConfig = ''
      [keyfile]
      path = /var/lib/NetworkManager/system-connections
      [connectivity]
      uri = http://google.cn/generate_204
      response = 
    '';
  };

  environment.systemPackages = with pkgs; [
    v2ray
    v2ray-geoip
    v2ray-domain-list-community
  ];

  networking.nameservers = [ "127.0.0.53" ];
  networking.usePredictableInterfaceNames = true;
}
