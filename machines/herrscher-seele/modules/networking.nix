{ config, ... }:
{
  services = {
    dae = {
      enable = true;
      disableTxChecksumIpGeneric = false;
      configFile = config.sops.templates."config.dae".path;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
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
      settings = {
        keyfile = {
          path = "/var/lib/NetworkManager/system-connections";
        };
        # https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/internet-explorer-edge-open-connect-corporate-public-network#ncsi-active-probes-and-the-network-status-alert
        connectivity = {
          uri = "http://www.msftconnecttest.com/connecttest.txt";
          response = "Microsoft Connect Test";
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
