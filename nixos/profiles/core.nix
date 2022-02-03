{ config, lib, pkgs, ... }: {
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
    editorconfig-core-c
    nixfmt
    nixpkgs-fmt
    man-pages
    unzip
    p7zip
    unar
    neofetch
    mediainfo
    inxi
    lshw
  ];

  nix = {
    settings = {
      sandbox = true;
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
        "https://berberman.cachix.org"
        "https://s3.nichi.co/cache"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
        "hydra.nichi.co-0:P3nkYHhmcLR3eNJgOAnHDjmQLkfqheGyhZ6GLrUVHwk="
      ];
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
    };
    gc.automatic = true;
    optimise.automatic = true;
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
      experimental-features = nix-command flakes
      flake-registry = /etc/nix/registry.json
    '';
    package = pkgs.nixUnstable;
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
    nix-build-shell = pkgs.writeScript "nix-build-shell" ''
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
  in { NIX_BUILD_SHELL = "${nix-build-shell}"; };

  # Udev
  services.udev.packages = with pkgs; [ android-udev-rules ];
}
