{
  flake = {
    overlays = {
      default = import ../../overlays;
      blender-bin = import ../../overlays/blender-bin.nix;
    };
  };
}
