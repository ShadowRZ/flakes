{
  flake.modules.nixos = {
    shell =
      _:
      {
        programs.adb.enable = true;
      };
  };
}
