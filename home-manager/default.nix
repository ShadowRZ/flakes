{ lib, ... }:
lib.pipe ./modules [
  (lib.fileset.fileFilter (f: f.hasExt "nix"))
  lib.fileset.toList
  (imports: { inherit imports; })
]
