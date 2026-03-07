{
  flake.modules.homeManager.base = _: {
    programs.command-not-found.enable = false;
  };
}
