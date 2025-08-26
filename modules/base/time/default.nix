{
  flake.modules = {
    nixos = {
      base =
        _:
        {
          time.timeZone = "Asia/Shanghai";
        };
    };
    nixOnDroid = {
      base =
        _:
        {
          time.timeZone = "Asia/Shanghai";
        };
    };
  };
}
