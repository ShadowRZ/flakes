{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    v2ray
    v2ray-geoip
    v2ray-domain-list-community
    (qv2ray.override { plugins = [ qv2ray-plugin-ss ]; })
  ];

  services.smartdns = {
    enable = true;
    settings = with pkgs; {
      conf-file = [
        "${smartdns-china-list}/accelerated-domains.china.smartdns.conf"
        "${smartdns-china-list}/apple.china.smartdns.conf"
        "${smartdns-china-list}/google.china.smartdns.conf"
      ];
      bind = [ "127.0.0.53:53" ];
      server-https = [
        "https://dns.alidns.com/dns-query -group china -exclude-default-group"
        "https://dns.quad9.net/dns-query"
        "https://101.6.6.6:8443/dns-query"
      ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  networking.networkmanager = {
    enable = true;
    dns = "none";
    extraConfig = ''
      [keyfile]
      path = /var/lib/NetworkManager/system-connections
    '';
  };

  networking.nameservers = [ "127.0.0.53" ];
  networking.usePredictableInterfaceNames = true;
}
