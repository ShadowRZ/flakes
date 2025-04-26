{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Disable nix-channel
  nix.channel.enable = false;
  nix.settings.flake-registry = "/etc/nix/registry.json";

  nixpkgs.flake.setNixPath = true;
  nixpkgs.flake.setFlakeRegistry = true;

  # Does not work with Flake based configurations
  system.copySystemConfiguration = false;
  programs.command-not-found.enable = false;
}
