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

    nixfmt
    nil
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.05";

  # Set up nix for flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds= cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU=
    '';
    substituters = lib.mkForce [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://berberman.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.garnix.io"
      "https://nix-on-droid.cachix.org"
    ];
  };

  # Set your time zone
  time.timeZone = "Asia/Shanghai";

  user.shell = "${pkgs.zsh}/bin/zsh";
}

