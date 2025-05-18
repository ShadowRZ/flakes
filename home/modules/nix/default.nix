{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style
    statix
    deadnix
    nixpkgs-fmt
    sops
    taplo
  ];
}
