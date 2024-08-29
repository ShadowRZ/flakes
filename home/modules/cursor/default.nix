{ pkgs, ... }: {
  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };
}
