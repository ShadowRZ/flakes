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
    ncdu
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
    fastfetch
    mediainfo
    inxi
    lshw
    screen
    pciutils
    aria2
    stdenv # Stdenv
  ];

  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://berberman.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        "https://shadowrz.cachix.org"
        "https://cache.garnix.io"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      keep-derivations = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
        "auto-allocate-uids"
        "cgroups"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
      use-xdg-base-directories = true;
    };
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
    # Nix-Index
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    # Enable Comma
    nix-index-database.comma.enable = true;
  };

  # Getty
  services = {
    getty = {
      greetingLine = with config.system.nixos; ''
        Hanekokoro OS
        Configuration Revision = ${config.system.configurationRevision}

        Based on NixOS ${release} (${codeName})
        Revision = ${revision}
      '';
    };
    # Udev
    udev.packages = with pkgs; [ android-udev-rules ];
  };

  services.fwupd.enable = true;

  environment.variables = let
    nix-build-shell = pkgs.writeScript "nix-build-shell" ''
      #!${pkgs.runtimeShell}
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

  nixpkgs.overlays = [ (import ./override/package-overlay.nix) ];

  documentation.doc.enable = lib.mkForce false;
}
