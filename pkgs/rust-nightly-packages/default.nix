{ pkgs, fenix }:
let
  rustPlatform = pkgs.makeRustPlatform {
    inherit (fenix.minimal) cargo rustc;
  };
  callPackage = path: o: pkgs.callPackage path ({ rustPlatform = rustPlatform; } // o);
in {
  taskmaid = callPackage ./taskmaid { };
}
