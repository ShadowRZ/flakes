{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  systems = inputs.nixpkgs.lib.systems.flakeExposed;

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
      directory:
      builtins.mapAttrs (_: v: import (directory + "/${v}")) (
        filterNullAttrValue (getDir directory "default.nix")
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
      directory:
      inputs.nixpkgs.lib.attrsets.mapAttrs' (name: path: {
        name = inputs.nixpkgs.lib.strings.removeSuffix ".nix" name;
        value = import (directory + "/${path}");
      }) (filterNullAttrValue (getFiles directory));
  };

  perSystem =
    { system, ... }:
    {
      treefmt.config = import ./treefmt.nix;

      # Instance a global Nixpkgs
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.self.overlays.default
          inputs.self.overlays.blender-bin
          inputs.self.overlays.firefox-addons

          inputs.nix-indexdb.overlays.nix-index
          inputs.shadowrz.overlays.default
        ];
        config = {
          allowUnfree = true;
          allowInsecurePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [ "electron" ];
          # https://developer.android.google.cn/studio/terms
          android_sdk.accept_license = true;
        };
      };
    };
}
