{ config, ... }:
{
  flake = {
    meta = {
      system.nixos.herrscher-seele = "x86_64-linux";
    };

    modules.nixos = {
      "hosts/herrscher-seele" = {
        imports =
          with config.flake.modules.nixos;
          [
            base
            bluetooth
            desktop
            # dev
            # dev-desktop
            fwupd
            gnupg
            hardening
            nix
            plasma-desktop
            shell
            sound

            root
            shadowrz
          ]
          ++ [
            {
              home-manager.users.shadowrz = {
                imports = with config.flake.modules.homeManager; [
                  base
                  desktop
                  dev
                  dev-desktop
                  gnupg
                  shell
                ];
              };
            }
          ];
      };
    };
  };
}
