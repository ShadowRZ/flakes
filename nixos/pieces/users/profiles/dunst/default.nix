{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
      size = "16x16";
    };

    settings = {
      global = {
        font = "等距更纱黑体 Slab SC 14";
        format = ''<b>%s</b>\n%b'';
      };
    };
  };
}
