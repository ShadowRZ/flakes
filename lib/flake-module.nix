{ inputs, ... }:
{
  flake.lib = import ./. { inherit (inputs.nixpkgs) lib; };
}
