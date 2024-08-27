{
  inputs,
  pkgs,
  lib,
  ...
}: {
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
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    registry = {nixpkgs.flake = inputs.nixpkgs;};
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU= shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0=
    '';
    substituters = lib.mkForce [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nix-on-droid.cachix.org"
      "https://shadowrz.cachix.org"
      "https://cache.garnix.io"
    ];
  };

  terminal.font = "${pkgs.nur.repos.shadowrz.iosevka-minoko-term}/share/fonts/truetype/IosevkaMinokoTerm-Regular.ttf";

  # https://github.com/catppuccin/termux/blob/68f0b175e5ba18bdb0ff01607f29fb5ecc6eb2c5/Mocha/colors.properties
  terminal.colors = {
    background = "#1e1e2e";
    foreground = "#cdd6f4";
    color0 = "#45475a";
    color8 = "#585b70";
    color1 = "#f38ba8";
    color9 = "#f38ba8";
    color2 = "#a6e3a1";
    color10 = "#a6e3a1";
    color3 = "#f9e2af";
    color11 = "#f9e2af";
    color4 = "#89b4fa";
    color12 = "#89b4fa";
    color5 = "#f5c2e7";
    color13 = "#f5c2e7";
    color6 = "#94e2d5";
    color14 = "#94e2d5";
    color7 = "#bac2de";
    color15 = "#a6adc8";
  };

  # Set your time zone
  time.timeZone = "Asia/Shanghai";

  home-manager = {
    useGlobalPkgs = true;
    config = ../home;
    sharedModules = [
      {
        imports = with inputs; [
          nix-indexdb.hmModules.nix-index
          {
            programs.nix-index-database.comma.enable = true;
          }
        ];
      }
    ];
  };

  user.shell = lib.getExe pkgs.zsh;
  environment.sessionVariables."SHELL" = lib.getExe pkgs.zsh;
  environment.sessionVariables."PAGER" = lib.getExe pkgs.less;
}
