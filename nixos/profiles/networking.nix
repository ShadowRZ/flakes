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
      server-https = [
        "https://dns.alidns.com/dns-query -group china -exclude-default-group"
        "https://185.222.222.222/dns-query"
      ];
      server-tls = [ "9.9.9.9:853" ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  ## Keybase / KBFS
  services.keybase.enable = true;
  services.kbfs = {
    enable = true;
    extraFlags = [ "-label kbfs" "-mount-type normal" ];
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
