{
  flake.modules.nixos = {
    desktop = _: {
      networking.networkmanager = {
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
          "interface-name:waydroid*"
          "lo"
        ];
      };
    };
  };
}
