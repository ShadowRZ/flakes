{ lib, ... }: {
  boot = {
    kernelParams = lib.mkAfter [
      "quiet"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
  };
}
