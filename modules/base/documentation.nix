{
  flake.modules.nixos = {
    base = {
      documentation = {
        # NixOS manual pages depends on <nixpkgs/nixos> store path
        # Which can cause unrelated derivation changes between NixOS updates
        enable = false;
        doc.enable = false;
        info.enable = false;

        # Enable man-db
        man.man-db.enable = true;
      };
    };
  };
}
