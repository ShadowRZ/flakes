{ inputs, pkgs, lib, ... }: {

  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
    # Flake Inputs
    inputs.nixos-wsl.nixosModules.wsl
    inputs.nur.nixosModules.nur
    inputs.nix-indexdb.nixosModules.nix-index
  ];

  networking.hostName = "unknown-dimensions";

  wsl = {
    enable = true;
    defaultUser = "shadowrz";
    nativeSystemd = true;
  };

  users = {
    users = {
      shadowrz = {
        shell = pkgs.zsh;
        description = "紫叶零湄";
        packages = with pkgs;
          [
            hugo # Hugo
          ];
      };
    };
  };

  environment = {
    defaultPackages = lib.mkForce [ ];
    # System level packages.
    systemPackages = with pkgs; [
      dnsutils
      fd
      iputils
      ripgrep
      file
      gdu
      wget
      tree
      man-pages
      unzip
      p7zip
      unar
    ];
    # Link /share/zsh
    pathsToLink = [ "/share/zsh" ];
    shellAliases = lib.mkForce {
      df = "df -h";
      du = "du -h";
      grep = "grep --color=auto";
      ls = "ls -h --group-directories-first --color=auto";

      chmod = "chmod --preserve-root -v";
      chown = "chown --preserve-root -v";

      ll = "ls -l";
      l = "ll -A";
      la = "ls -a";
    };
  };

  # Configure Nix.
  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store?priority=10"
        "https://mirrors.bfsu.edu.cn/nix-channels/store?priority=10"
        "https://cache.nixos.org?priority=10"
        "https://cache.garnix.io?priority=20"
        "https://shadowrz.cachix.org?priority=30"
        "https://berberman.cachix.org?priority=30"
        "https://nix-community.cachix.org?priority=30"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      keep-derivations = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      http-connections = 0;
      max-substitution-jobs = 128;
    };
  };

  # Misc
  nixpkgs = {
    overlays = [
      (final: prev: {
        # lilydjwg/subreap
        zsh = prev.zsh.overrideAttrs (attrs: {
          patches = (attrs.patches or [ ])
            ++ [ ../nixos-modules/patches/zsh-subreap.patch ];
        });
      })
    ];
  };

  # System programs
  programs = {
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      enableLsColors = false;
    };
    # Disable command-not-found as it's unavliable in Flakes build
    command-not-found.enable = lib.mkForce false;
    # Nix-Index
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    # Enable Comma
    nix-index-database.comma.enable = true;
  };

  # Disable all HTML documentations.
  documentation.doc.enable = lib.mkForce false;

  # Configuration revision.
  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

  # Set your time zone
  time.timeZone = "Asia/Shanghai";

  # DO NOT FIDDLE WITH THIS VALUE !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  # Before changing this value (which you shouldn't do unless you have
  # REALLY NECESSARY reason to do this) read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  # and release notes, SERIOUSLY.
  system.stateVersion = "24.05";

}
