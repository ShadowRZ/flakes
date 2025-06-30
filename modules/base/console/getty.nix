{
  flake.modules.nixos = {
    base =
      { config, ... }:
      {
        services.getty.greetingLine = with config.system.nixos; ''
          NixOS ${release} (${codeName})
          \e{lightmagenta}Codename Hanekokoro
        '';
      };
  };
}
