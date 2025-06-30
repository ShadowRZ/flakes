{
  flake.modules.nixos = {
    shell = {
      programs.adb.enable = true;
    };
  };
}
