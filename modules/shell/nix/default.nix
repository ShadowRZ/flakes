{
  flake.modules.homeManager = {
    shell =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nixd
          nixfmt-rfc-style
          statix
          deadnix
          nixpkgs-fmt
          sops
          taplo
        ];
      };
  };
}
