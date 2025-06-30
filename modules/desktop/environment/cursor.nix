{
  flake.modules = {
    nixos = {
      desktop = {
        services.displayManager.sddm.settings = {
          Theme = {
            CursorTheme = "BreezeX-RosePineDawn-Linux";
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
            package = pkgs.rose-pine-cursor;
            name = "BreezeX-RosePineDawn-Linux";
            size = 32;
            gtk.enable = true;
            x11.enable = true;
          };
        };
    };
  };
}
