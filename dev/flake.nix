{
  inputs = {
    # Treefmt
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      # The Nixpkgs input is only used for its own checks and formatters,
      # and we only require its flake module which is independent.
      inputs.nixpkgs.follows = "";
    };
  };

  outputs = _: { };
}
