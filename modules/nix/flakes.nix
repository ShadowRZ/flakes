{ inputs, ... }:
{
  flake.modules = {
    nixos = {
      nix = _: {
        # Enable Flakes
        nix.settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          flake-registry = "";
        };

        # Disable nix-channel
        nix.channel.enable = false;

        nixpkgs.flake.setNixPath = true;
        nixpkgs.flake.setFlakeRegistry = true;

        # Does not work with Flake based configurations
        system.copySystemConfiguration = false;
      };
    };

    nixOnDroid = {
      nix = _: {
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
