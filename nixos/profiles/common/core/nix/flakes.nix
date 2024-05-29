{ inputs, lib, pkgs, ... }: {
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Disable nix-channel
  nix.channel.enable = false;

  # Disable flake-registry
  nix.settings.flake-registry = "";

  # Add each flake input as a registry
  # To make nix3 commands consistent with the flake
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

  # Install Git
  environment.systemPackages = [ pkgs.git ];

  # Does not work with Flake based configurations
  system.copySystemConfiguration = false;
  programs.command-not-found.enable = false;
}
