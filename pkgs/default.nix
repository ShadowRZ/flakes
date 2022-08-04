{ pkgs ? import <nixpkgs> {} }: {
  kose-font = pkgs.callPackage ./kose-font { };
  adw-gtk3 = pkgs.callPackage ./adw-gtk3 { };
  sddm-lain-wired-theme = pkgs.callPackage ./sddm-lain-wired-theme { };
  sddm-sugar-candy = pkgs.callPackage ./sddm-sugar-candy { };
  mkxp-z = pkgs.callPackage ./mkxp-z {};
}
