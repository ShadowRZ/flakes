{
  networking = {
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
