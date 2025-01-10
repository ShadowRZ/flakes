{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Disable nix-channel
  nix.channel.enable = false;
  # Disable flake-registry
  nix.settings.flake-registry = "";
  # Manually set NIX_PATH
  nix.settings.nix-path = [ "nixpkgs=flake:nixpkgs" ];

  nixpkgs.flake.setNixPath = false; # Set manually
  nixpkgs.flake.setFlakeRegistry = false;

  # Does not work with Flake based configurations
  system.copySystemConfiguration = false;
  programs.command-not-found.enable = false;
}
