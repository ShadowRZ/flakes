# final: Final overlayed Nixpkgs.
# prev: Nixpkgs before applying this overlay.
final: prev: {
  material-decoration = prev.callPackage ./material-decoration { };
}
