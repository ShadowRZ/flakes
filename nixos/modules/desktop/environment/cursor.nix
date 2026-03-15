{
  flake.modules = {
    homeManager = {
      desktop =
        _:
        {
          home.pointerCursor = {
            size = 32;
            gtk.enable = true;
            x11.enable = true;
          };
        };
    };
  };
}
