{
  boot = {
    loader = {
      timeout = 0;
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        graceful = true;
      };
    };
  };
}
