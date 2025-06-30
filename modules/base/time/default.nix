{
  flake.modules = {
    nixos = {
      base = {
        time.timeZone = "Asia/Shanghai";
      };
    };
    nix-on-droid = {
      base = {
        time.timeZone = "Asia/Shanghai";
      };
    };
  };
}
