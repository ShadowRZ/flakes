{ inputs, ... }:
{
  # Add Flake Parts flake module for modules feature.
  imports = [ inputs.flake-parts.flakeModules.modules ];
}
