{
  projectRootFile = "flake.nix";

  ### nix
  programs.deadnix.enable = true;
  programs.statix.enable = true;
  programs.alejandra.enable = true;
}
