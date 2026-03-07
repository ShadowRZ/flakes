{
  flake.modules.nixos = {
    base = _: {
      documentation = {
        enable = true;
        doc.enable = false;
        info.enable = false;

        # Enable man-db
        man.man-db.enable = true;
      };
    };
  };
}
