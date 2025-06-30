{ inputs, ... }:
{
  flake.modules = {
    nixos = {
      nix =
        { lib, ... }:
        {
          # Enable Flakes
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];

          # Disable nix-channel
          nix.channel.enable = false;

          nixpkgs.flake.setNixPath = true;
          nixpkgs.flake.setFlakeRegistry = true;

          # Does not work with Flake based configurations
          system.copySystemConfiguration = false;
        };
    };

    nix-on-droid = {
      nix =
        { ... }:
        {
          nix = {
            nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
            registry = {
              nixpkgs.flake = inputs.nixpkgs;
            };
          };
        };
    };
  };
}
