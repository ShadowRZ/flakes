{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = [ inputs.catppuccin-nix.nixosModules.default ];

    catppuccin = {
      accent = "rosewater";
      flavor = "mocha";

      # keep-sorted start block=yes
      cursors = {
        enable = true;
      };
      tty = {
        enable = true;
      };
      # keep-sorted end
    };
  };
}
