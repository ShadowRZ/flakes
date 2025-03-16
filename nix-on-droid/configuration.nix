{
  pkgs,
  lib,
  ...
}:
{
  environment.packages = with pkgs; [
    openssh

    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip

    dnsutils
    ripgrep
    file
    gdu
    wget
    tree
    man-pages
    curl
    ncurses
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.05";

  # Set up nix for flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU= shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0=
    '';
    substituters = lib.mkForce [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      "https://nix-on-droid.cachix.org"
      "https://shadowrz.cachix.org"
      "https://cache.garnix.io"
      "https://cache.nixos.org"
    ];
  };

  terminal.font = "${pkgs.iosevka-minoko-term}/share/fonts/truetype/IosevkaMinokoTerm-Regular.ttf";

  # https://github.com/rose-pine/termux/blob/f6f6375e1118cd374b9e7b74de1c23c7becb5913/app/src/main/assets/colors/ros%C3%A9-pine.properties
  terminal.colors = {
    background = "#191724";
    foreground = "#e0def4";
    cursor = "#6e6a86";
    color0 = "#26233a";
    color8 = "#6e6a86";
    color1 = "#eb6f92";
    color9 = "#eb6f92";
    color2 = "#31748f";
    color10 = "#31748f";
    color3 = "#f6c177";
    color11 = "#f6c177";
    color4 = "#9ccfd8";
    color12 = "#9ccfd8";
    color5 = "#c4a7e7";
    color13 = "#c4a7e7";
    color6 = "#ebbcba";
    color14 = "#ebbcba";
    color7 = "#e0def4";
    color15 = "#e0def4";
  };

  # Set your time zone
  time.timeZone = "Asia/Shanghai";

  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
    xdg-open.enable = true;
  };

  user.shell = lib.getExe pkgs.zsh;
  environment.sessionVariables."SHELL" = lib.getExe pkgs.zsh;
  environment.sessionVariables."PAGER" = lib.getExe pkgs.less;
  environment.sessionVariables."EDITOR" = "nvim";
}
