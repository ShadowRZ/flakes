{
  flake.modules.nixos = {
    base = _: {
      system.tools = {
        nixos-option.enable = true;
        nixos-version.enable = false;
        nixos-generate-config.enable = false;
      };
    };
  };
}
