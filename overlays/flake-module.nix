{ inputs, ... }:
{
  flake = {
    overlays = {
      default = import ./.;
      blender-bin = import ./blender-bin.nix;
      firefox-addons =
        _self: super:
        let
          rycee = import inputs.rycee-firefox {
            pkgs = super;
          };
          shadowrz = super.callPackage ./firefox-addons.nix { inherit (rycee) buildFirefoxXpiAddon; };
        in
        {
          firefox-addons = rycee.firefox-addons // shadowrz;
          mozilla-addons-to-nix = rycee.mozilla-addons-to-nix;
        };
    };
  };
}
