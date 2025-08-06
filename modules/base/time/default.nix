{
  flake.modules = {
    nixos = {
      base = {
        time.timeZone = "Asia/Shanghai";
      };
    };
    nixOnDroid = {
      base = {
        time.timeZone = "Asia/Shanghai";
      };
    };
  };
}
