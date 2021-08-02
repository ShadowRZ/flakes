{ config, lib, pkgs, ... }:

{
  # System level packages.
  environment.systemPackages = with pkgs; [
    binutils
    coreutils
    curl
    dnsutils
    dosfstools
    fd
    git
    gptfdisk
    htop
    iputils
    jq
    moreutils
    nmap
    ripgrep
    skim
    utillinux
    whois
    file
    less
    ncdu
    tig
    wget
    htop
    tree
    shellcheck
    cmark
    editorconfig-core-c
    nixfmt
    nixpkgs-fmt
    stdmanpages
    unzip
    p7zip
    unar
    convmv
  ];

  nix = {
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
    useSandbox = true;
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
      experimental-features = nix-command flakes
    '';
    binaryCaches = pkgs.lib.mkForce [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nichi.workers.dev"
      "https://berberman.cachix.org"
      "https://nichi.cachix.org"
      "https://nix-community.cachix.org"
    ];
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
      "nichi.cachix.org-1:ZWn4Jui6odEcNEMjcHM/WXbDSVO4Ai+jrzWHf+pqwj0="
    ];
    package = pkgs.nixUnstable;
  };

  programs.bash = {
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
    '';
  };

  # System programs
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = { enable = true; };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryFlavor = "qt";
    };
    mtr = { enable = true; };
    command-not-found = { enable = true; };
    dconf = { enable = true; };
  };
}
