{ withSystem, inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      herrscher-seele = withSystem "x86_64-linux" (
        { pkgs, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            # Global Flake Inputs
            inputs.nixpkgs.nixosModules.notDetected
            inputs.nixos-sensible.nixosModules.default
            inputs.disko.nixosModules.disko
            inputs.sops-nix.nixosModules.sops
            # Foundation
            inputs.home-manager.nixosModules.home-manager
            inputs.self.nixosModules.default
            # OS core parts
            inputs.self.nixosModules.graphical
            inputs.self.nixosModules.hardening
            inputs.self.nixosModules.networking
            inputs.self.nixosModules.nix
            inputs.self.nixosModules.with-flake-revision
            inputs.self.nixosModules.flake-registry
            # Perservation
            inputs.preservation.nixosModules.preservation
            # Lanzaboote
            inputs.lanzaboote.nixosModules.lanzaboote
            # Hardware
            inputs.nixpkgs.nixosModules.notDetected
            inputs.nixos-sensible.nixosModules.zram
            # Machine specific templates
            inputs.self.nixosModules.pam-fido2
            inputs.self.nixosModules.lanzaboote
            inputs.self.nixosModules.plasma-desktop
            # Home Manager
            {
              home-manager = {
                sharedModules = [
                  inputs.self.hmModules.default
                  inputs.self.hmModules.shell
                ];
                users = {
                  shadowrz = {
                    imports = [
                      inputs.self.hmModules.emacs
                      inputs.self.hmModules.firefox
                      inputs.self.hmModules.mpv
                      inputs.self.hmModules.fontconfig
                      inputs.self.hmModules.gtk
                      inputs.self.hmModules.obs
                      inputs.self.hmModules.cursor
                      inputs.self.hmModules.vscode
                    ];
                  };
                };
              };
            }
            # Configure Nixpkgs
            {
              imports = [ inputs.nixpkgs.nixosModules.readOnlyPkgs ];
              nixpkgs = {
                inherit pkgs;
              };
            }
            # Configuration entrypoint
            ./configuration.nix
          ];
        }
      );
    };
  };
}
