{
  flake.modules.nixos = {
    base =
      {
        config,
        lib,
        ...
      }:
      {
        config = lib.mkMerge [
          # Enable Plymouth by default
          {
            boot.plymouth = {
              enable = lib.mkDefault true;
              theme = "bgrt";
            };
          }
          # Enable silent boot if Plymouth is enabled
          (lib.mkIf config.boot.plymouth.enable {
            boot = {
              kernelParams = lib.mkAfter [
                "quiet"
                "udev.log_priority=3"
                "vt.global_cursor_default=0"
              ];
              initrd.verbose = false;
              consoleLogLevel = 0;
            };
          })
        ];
      };
  };
}
