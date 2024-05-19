{ pkgs ? import <nixpkgs> { } }:

{
  klassy-qt6 = pkgs.kdePackages.callPackage ./klassy-qt6 { };
}
