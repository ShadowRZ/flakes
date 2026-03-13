{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      treefmt.config = {
        projectRootFile = "flake.nix";

        ### nix
        programs.deadnix.enable = true;
        programs.statix.enable = true;
        programs.nixfmt.enable = true;

        ### Keep Sorted
        programs.keep-sorted.enable = true;
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = [
          config.treefmt.build.wrapper
          # keep-sorted start
          pkgs.deadnix
          pkgs.just
          pkgs.keep-sorted
          pkgs.nixd
          pkgs.nixfmt
          pkgs.statix
          # keep-sorted end
        ];
      };
    };
}
