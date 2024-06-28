{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports =
    [./hardening ./networking ./nix]
    ++ (with inputs; [
      # Global Flake Inputs
      nixpkgs.nixosModules.notDetected
      impermanence.nixosModules.impermanence
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
      nur.nixosModules.nur
      nix-indexdb.nixosModules.nix-index
      disko.nixosModules.disko
      nixos-sensible.nixosModules.default
      lanzaboote.nixosModules.lanzaboote
    ]);

  nixpkgs.overlays = [
    inputs.berberman.overlays.default
    inputs.blender.overlays.default
    inputs.self.overlays.default
  ];

  # Stores system revision.
  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

  ## Home Manager
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit (config) nur;
    };
    users = {
      shadowrz = import ../../../../home;
      root = {
        imports = [
          ../../../../home
          {
            home.username = "root";
            home.homeDirectory = "/root";
          }
        ];
      };
    };
  };

  sops = {
    defaultSopsFile = ../../../../secrets.yaml;
    age = {
      keyFile = "/var/lib/sops.key";
      sshKeyPaths = [];
    };
    gnupg.sshKeyPaths = [];
    secrets = {passwd = {neededForUsers = true;};};
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.tmp.useTmpfs = true;
  boot.plymouth = {
    enable = true;
    font = "${config.nur.repos.shadowrz.iosevka-minoko}/share/fonts/truetype/IosevkaMinoko-ExtendedBold.ttf";
    theme = "angular_alt";
    themePackages = [pkgs.adi1090x-plymouth-themes];
  };

  services.getty.greetingLine = with config.system.nixos; ''
    NixOS ${release} (${codeName})
    https://github.com/NixOS/nixpkgs/tree/${revision}

    \e{lightmagenta}Project Hanekokoro
    https://github.com/ShadowRZ/flakes/tree/${config.system.configurationRevision}\e{reset}
  '';

  # Users
  users = {
    mutableUsers = false;
    users = {
      shadowrz = {
        uid = 1000;
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "夜坂雅";
        extraGroups = ["wheel"];
      };
    };
  };

  # Configure fallback console.
  console = {
    packages = with pkgs; [terminus_font];
    earlySetup = true;
    font = "ter-i32b";
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
        builtins.elem (lib.getName pkg) ["vscode" "code"]
        || pkgs.lib.any
        (prefix: pkgs.lib.hasPrefix prefix (pkgs.lib.getName pkg)) [
          "steam"
          "nvidia"
        ];
      # Solely allows Electron
      allowInsecurePredicate = pkg:
        builtins.elem (pkgs.lib.getName pkg) ["electron"];
    };
  };

  environment = {
    # System level packages.
    systemPackages = with pkgs; [
      dnsutils
      pciutils
      usbutils
      lsof
      ltrace
      strace
      file
      gdu
      wget
      tree
      unzip
      p7zip
      unar
    ];
    # Link /share/zsh
    pathsToLink = ["/share/zsh"];
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
      VK_ICD_FILENAMES = "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";
    };
  };

  # System programs
  programs = {
    adb.enable = true;
    nano.enable = false;
    vim.defaultEditor = false;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      enableLsColors = false;
    };
    ssh = {startAgent = true;};
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
    supportedLocales = ["all"];
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

  services = {
    # Generate ZRAM
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
    fstrim.enable = true;
    dbus.implementation = "broker";
  };

  powerManagement.powertop.enable = true;

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
