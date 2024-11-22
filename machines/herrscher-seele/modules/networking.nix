{ config, ... }: {
  services = {
    dae = {
      enable = true;
      disableTxChecksumIpGeneric = false;
      configFile = config.sops.templates."config.dae".path;
    };
  };

  sops = {
    templates = {
      "config.dae".content = ''
        ${builtins.readFile ./dae.conf}
        ${config.sops.placeholder.dae}
      '';
    };
  };

  networking = {
    hostName = "herrscher-seele";
    stevenblack.enable = true;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.backend = "iwd";
      settings = {
        keyfile = {
          path = "/var/lib/NetworkManager/system-connections";
        };
        connectivity = {
          uri = "http://google.cn/generate_204";
          response = "";
        };
      };
      unmanaged = [
        "interface-name:virbr*"
        "lo"
      ];
    };
    nftables = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowPing = true;
      trustedInterfaces = [ "virbr0" ];
    };
  };
}
