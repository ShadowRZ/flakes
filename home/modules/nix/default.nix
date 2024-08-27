{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    alejandra
    statix
    deadnix

    nixpkgs-fmt

    sops
  ];
}
