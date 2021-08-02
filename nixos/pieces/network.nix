{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    v2ray
    v2ray-geoip
    v2ray-domain-list-community
    (qv2ray.override { plugins = [ qv2ray-plugin-ss ]; })
  ];

  services.resolved = {
    enable = true;
    fallbackDns = [ "223.5.5.5" "223.6.6.6" ];
  };

  services.smartdns = {
    enable = true;
    settings = with pkgs; {
      conf-file = [
        "${smartdns-china-list}/accelerated-domains.china.smartdns.conf"
        "${smartdns-china-list}/apple.china.smartdns.conf"
        "${smartdns-china-list}/google.china.smartdns.conf"
      ];
      bind = [ "127.0.53.53:53" ];
      server-https = [
        "https://223.5.5.5/dns-query -group china -exclude-default-group"
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
    dns = "systemd-resolved";
    extraConfig = ''
      [keyfile]
      path = /var/lib/NetworkManager/system-connections
      [global-dns-domain-*]
      servers=127.0.53.53
    '';
  };
  networking.usePredictableInterfaceNames = true;
}
