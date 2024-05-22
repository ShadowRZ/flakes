{ inputs, config, pkgs, lib, ... }: {

  imports = [
    # Global Flake Inputs
    inputs.nixpkgs.nixosModules.notDetected
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.nur.nixosModules.nur
    inputs.nix-indexdb.nixosModules.nix-index
    inputs.disko.nixosModules.disko
  ];

  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

  boot = {
    # Kernel.
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = lib.mkAfter [
      "quiet"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
    ];
    tmp.useTmpfs = true;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    consoleLogLevel = 0;
    plymouth.enable = true;
  };

  nix = { };
  # Configure Nix.
  nix = {
    channel.enable = false;
    registry = { nixpkgs.flake = inputs.nixpkgs; };
    settings = {
      nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkForce [
        "https://mirror.sjtu.edu.cn/nix-channels/store?priority=10"
        "https://mirrors.bfsu.edu.cn/nix-channels/store?priority=10"
        "https://cache.nixos.org?priority=15"
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
      http-connections = 0;
      max-substitution-jobs = 128;
    };
  };

  # Configure fallback console.
  console = {
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
    font = "ter-132b";
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  networking = {
    # Disable global DHCP
    useDHCP = false;
    # Disable firewall
    firewall.enable = false;
    # Enable NAT
    nat.enable = true;
    # Predictable interfaces
    usePredictableInterfaceNames = true;
  };

  # Misc
  nixpkgs = {
    config = {
      # Solely allows some packages
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [ "vscode" "code" ] || pkgs.lib.any
        (prefix: pkgs.lib.hasPrefix prefix (pkgs.lib.getName pkg)) [
          "steam"
          "nvidia"
        ];
      # Solely allows Electron
      allowInsecurePredicate = pkg:
        builtins.elem (pkgs.lib.getName pkg) [ "electron" ];
    };
    overlays = [
      inputs.berberman.overlays.default
      inputs.self.overlays.default
      inputs.blender.overlays.default
      (final: prev: {
        # lilydjwg/subreap
        zsh = prev.zsh.overrideAttrs (attrs: {
          patches = (attrs.patches or [ ]) ++ [ ./patches/zsh-subreap.patch ];
        });
      })
    ];
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
      nixfmt
      nil
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
    variables = {
      VK_ICD_FILENAMES =
        "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";
    };
  };

  # System programs
  programs = {
    adb.enable = true;
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      enableLsColors = false;
    };
    ssh = { startAgent = true; };
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

  i18n = {
    defaultLocale = "C.UTF-8";
    # Build all Glibc supported locales as defined in:
    # https://sourceware.org/git/?p=glibc.git;a=blob;f=localedata/SUPPORTED
    # This is because Home Manager actually configures a locale archive
    # which is built with all supported locales and exports
    # LOCALE_ARCHIVE_2_27.
    # Unfortunately this means other users, especially root with sudo,
    # various applications stop supporting user's current locale as they
    # lost LOCALE_ARCHIVE_2_27 and taken LOCALE_ARCHIVE which is not built
    # with all locales like Home Manager.
    # Especially Perl which gave warning if it can't use such locale.
    supportedLocales = [ "all" ];
  };

  security.pam.loginLimits = [{
    domain = "*";
    type = "-";
    item = "memlock";
    value = "unlimited";
  }];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit (config) nur; };
  };

  services = {
    # Generate ZRAM
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
    pcscd.enable = true;
    fstrim.enable = true;
    dbus.implementation = "broker";
  };

  powerManagement.powertop.enable = true;

  # Disable all HTML documentations.
  documentation.doc.enable = lib.mkForce false;

  # DO NOT FIDDLE WITH THIS VALUE !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  # Before changing this value (which you shouldn't do unless you have
  # REALLY NECESSARY reason to do this) read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  # and release notes, SERIOUSLY.
  system.stateVersion = "24.05"; # Did you read the comment?
}
