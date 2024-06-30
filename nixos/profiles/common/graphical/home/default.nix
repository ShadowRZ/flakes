{
  imports = map (n: ../../../../../home/profiles/${n}) [
    "firefox"
    "mpv"
    "dconf"
    "fontconfig"
    "gtk"
    "wezterm"
  ];
}
