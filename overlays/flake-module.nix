{
  flake = {
    overlays = {
      default = import ./.;
      blender-bin = import ./blender-bin.nix;
    };
  };
}
