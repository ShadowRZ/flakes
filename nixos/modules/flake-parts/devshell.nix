{
  perSystem =
    { config, pkgs, ... }:
    {
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
