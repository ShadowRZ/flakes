{ inputs, ... }:
{
  flake.lib = {
    modulesFromDirectory =
      let
        getDir =
          dir: file:
          builtins.mapAttrs (name: type: if type == "directory" then "${name}/${file}" else null) (
            builtins.readDir dir
          );
        filterNullAttrValue = attr: inputs.nixpkgs.lib.attrsets.filterAttrs (_: v: v != null) attr;
      in
      (
        directory:
        builtins.mapAttrs (_: v: import (directory + "/${v}")) (
          filterNullAttrValue (getDir directory "default.nix")
        )
      );
    modulesFromFiles =
      let
        nixFileOrNull = file: if (inputs.nixpkgs.lib.strings.hasSuffix ".nix" file) then file else null;
        getFiles =
          dir:
          builtins.mapAttrs (name: type: if type == "regular" then (nixFileOrNull name) else null) (
            builtins.readDir dir
          );
        filterNullAttrValue = attr: inputs.nixpkgs.lib.attrsets.filterAttrs (_: v: v != null) attr;
      in
      (
        directory:
        inputs.nixpkgs.lib.attrsets.mapAttrs' (name: path: {
          name = inputs.nixpkgs.lib.strings.removeSuffix ".nix" name;
          value = import (directory + "/${path}");
        }) (filterNullAttrValue (getFiles directory))
      );
  };
  perSystem = {
    treefmt.config = import ./treefmt.nix;
  };
}
