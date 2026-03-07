{ lib, ... }:
{
  options.flake.meta = lib.mkOption {
    type = with lib.types; lazyAttrsOf anything;
    description = ''
      A set of freeform attributes for flake internal usage.
    '';
  };

  config.flake.meta.uri = "github:ShadowRZ/flakes";
}
