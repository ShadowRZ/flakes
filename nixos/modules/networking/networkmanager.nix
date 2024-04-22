{
  # Use NetworkManager
  networking.networkmanager = {
    enable = true;
    dns = "dnsmasq";
    extraConfig = ''
      [keyfile]
      path = /var/lib/NetworkManager/system-connections
      [connectivity]
      uri = http://google.cn/generate_204
      response =
    '';
    unmanaged = [ "interface-name:virbr*" "lo" ];
    # Disable resolvconf
    # Otherwise NetworkManager would use resolvconf to update /etc/resolv.conf
    resolvconf.enable = false;
  };
  # Manually configures a working /etc/resolv.conf
  # since we don't have anyone to update it
  environment.etc."resolv.conf".text = ''
    nameserver 127.0.53.53
  '';
}
