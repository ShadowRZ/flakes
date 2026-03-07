{
  flake.modules.nixos = {
    base =
      { config, ... }:
      {
        services.getty.greetingLine = with config.system.nixos; ''
          NixOS ${release} (${codeName})
          \e{lightmagenta}Belongs to Hanekokoro Infra (https://github.com/ShadowRZ/flakes)
        '';
      };
  };
}
