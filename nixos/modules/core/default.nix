{ config, lib, pkgs, specialArgs, ... }: {
  # System level packages.
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    dnsutils
    dosfstools
    fd
    gptfdisk
    htop
    iputils
    jq
    ripgrep
    utillinux
    file
    less
    ncdu_1
    wget
    htop
    tree
    shellcheck
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
    screen
    pciutils
    aha
    stdenv # Stdenv
  ];

  nix = {
    settings = {
      sandbox = true;
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://berberman.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        "https://shadowrz.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
      ];
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
    };
    optimise.automatic = true;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = false
      fallback = true
      experimental-features = nix-command flakes
      flake-registry = /etc/nix/registry.json
    '';
  };

  # System programs
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = { enable = true; };
    # Disable command-not-found as it's unavliable in Flakes build
    command-not-found = { enable = lib.mkForce false; };
    dconf = { enable = true; };
  };

  # Getty
  services.getty = {
    greetingLine = with config.system.nixos; ''
      NixOS ${label} (${codeName})
      Revision = ${revision}
    '';
    helpLine = ''
      Configuration Revision = ${config.system.configurationRevision}
      Location               = ${specialArgs.configurationPath}
      Nixpkgs Location       = ${specialArgs.nixpkgsPath}
    '';
  };

  environment.variables = let
    nix-build-shell = pkgs.writeScript "nix-build-shell" ''
      #!${pkgs.bashInteractive}/bin/bash
      if [[ $IN_NIX_SHELL == 'pure' ]] || [[ $# -eq 1 ]]; then
        # $BASH -> Expands to the full filename used to invoke this instance of bash.
        exec "$BASH" "$@"
      fi

      # Remember the user shell.
      shell=$SHELL

      # nix-shell run this script as (shell) --rcfile $2
      rcfile="$2"
      source "$rcfile"

      export __USER_SHELL=$shell
      # Run user shell.
      exec -a "$shell" "$shell"
    '';
  in { NIX_BUILD_SHELL = "${nix-build-shell}"; };

  # Udev
  services.udev.packages = with pkgs; [ android-udev-rules ];

  documentation.doc.enable = lib.mkForce false;

  nixpkgs.overlays = [ (import ./override/package-overlay.nix) ];
}
