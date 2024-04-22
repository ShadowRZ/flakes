{
  # Set smartdns server
  networking.nameservers = [ "127.0.53.53" ];

  services = {
    # Smartdns
    smartdns = {
      enable = true;
      settings = {
        conf-file = [
          "${./files/accelerated-domains.china.smartdns.conf}"
          "${./files/apple.china.smartdns.conf}"
          "${./files/google.china.smartdns.conf}"
          "${./files/bogus-nxdomain.china.smartdns.conf}"
        ];
        bind = [ "127.0.53.53:53" ];
        server = [
          # Local Dnsmasq pushed by NetworkManager
          "127.0.0.1 -group china -exclude-default-group"
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
          "/cache.nixos.org/china"
        ];
        speed-check-mode = "tcp:443,tcp:80";
        # Add log
        log-level = "info";
        log-file = "/var/log/smartdns.log";
      };
    };
    # Avahi
    avahi = { enable = true; };
  };
}
