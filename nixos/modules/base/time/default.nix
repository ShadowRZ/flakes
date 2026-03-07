{
  flake.modules = {
    nixos = {
      base = _: {
        time.timeZone = "Asia/Shanghai";
      };
    };
  };
}
