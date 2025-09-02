{
  flake.modules = {
    nixos = {
      desktop = _: {
        services.displayManager.sddm.settings = {
          Theme = {
            CursorTheme = "Bibata-Modern-Ice";
            CursorSize = 32;
          };
        };
      };
    };
    homeManager = {
      desktop =
        { pkgs, ... }:
        {
          home.pointerCursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 32;
            gtk.enable = true;
            x11.enable = true;
          };
        };
    };
  };
}
