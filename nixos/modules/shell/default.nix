{
  flake.modules.nixos.shell = _: {
    programs.fish.enable = true;
  };
}
