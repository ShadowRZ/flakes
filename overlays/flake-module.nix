{ inputs, ... }:
{
  flake = {
    overlays = {
      default = import ./.;
      blender-bin = import ./blender-bin.nix;
      firefox-addons =
        self: super:
        let
          rycee = import "${inputs.rycee-firefox}/pkgs/firefox-addons" {
            inherit (super) fetchurl lib stdenv;
          };
          shadowrz = super.callPackage ./firefox-addons.nix { inherit (rycee) buildFirefoxXpiAddon; };
        in
        {
          firefox-addons = rycee // shadowrz;
        };
    };
  };
}
