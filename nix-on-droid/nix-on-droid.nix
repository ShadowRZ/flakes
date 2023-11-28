{ pkgs, lib, ... }: {

  environment.packages = with pkgs; [
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
    fd
    ripgrep
    file
    gdu
    wget
    tree
    man-pages
    curl

    hugo
    ncurses
    openssh
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.05";

  # Set up nix for flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    substituters = lib.mkBefore [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://berberman.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.garnix.io"
    ];
  };

  # Set your time zone
  time.timeZone = "Asia/Shanghai";

  user.shell = "${pkgs.zsh}/bin/zsh";
}

