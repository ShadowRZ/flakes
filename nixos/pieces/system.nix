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
    ripgrep
    utillinux
    file
    less
    ncdu
    wget
    htop
    tree
    shellcheck
    cmark
    editorconfig-core-c
    nixfmt
    nixpkgs-fmt
    man-pages
    man-pages-posix
    unzip
    p7zip
    unar
    neofetch
    mediainfo
    inxi
    lshw
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
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
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
    command-not-found = { enable = true; };
    dconf = { enable = true; };
  };

  environment.variables = let
    some-nix-shell = pkgs.writeScriptBin "some-nix-shell" ''
      #!${pkgs.bash}/bin/bash
      # Execute Bash in pure Nix Shell (Intended shell for nix-shell)
      if [[ $IN_NIX_SHELL == 'pure' ]]; then
        # $BASH -> Expands to the full filename used to invoke this instance of bash.
        exec "$BASH" "$@"
      fi

      # Remember the user shell.
      shell=$SHELL

      # nix-shell run this script as (shell) --rcfile $2
      rcfile="$2"
      source "$rcfile"

      # Run user shell.
      exec -a "$shell" "$shell"
    '';
  in { NIX_BUILD_SHELL = "${some-nix-shell}/bin/some-nix-shell"; };

  # Udev
  services.udev.packages = with pkgs; [ android-udev-rules ];
}
