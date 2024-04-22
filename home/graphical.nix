{ pkgs, lib, ... }: {
  programs = {
    ### Wezterm
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./files/wezterm.lua;
    };
    ### OBS
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
  };

  # Enable a Qt pinentry
  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry-qt;

  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      always-show-title-buttons = false;
      csd-enable = false;
      mpv-config-enable = true;
      mpv-config-file = "file:///${./files/celluloid.options}";
    };
  };
}
