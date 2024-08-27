{
  # Use NetworkManager
  networking.networkmanager = {
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
}
