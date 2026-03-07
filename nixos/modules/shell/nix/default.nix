{
  flake.modules.homeManager = {
    shell =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nixd
          nixfmt
          statix
          deadnix
          sops
          taplo
          nix-tree
          nh
        ];
      };
  };
}
