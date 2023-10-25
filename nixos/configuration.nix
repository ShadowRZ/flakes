{ config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      timeout = 0;
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        graceful = true;
      };
    };
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

  # Configure Nix.
  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      substituters = lib.mkBefore [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://berberman.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
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

  # Configure console.
  console = {
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
    font = "ter-132b";
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  networking = {
    # Hostname
    hostName = "hanekokoroos";
    # Use NetworkManager
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
      extraConfig = ''
        [keyfile]
        path = /var/lib/NetworkManager/system-connections
        [connectivity]
        uri = http://google.cn/generate_204
        response =
      '';
      unmanaged = [ "interface-name:virbr*" "lo" ];
    };
    # Disable global DHCP
    useDHCP = false;
    # Enable firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 8000 8080 ];
      allowedUDPPorts = [ 53 ];
      allowPing = true;
      trustedInterfaces = [ "virbr0" ];
    };
    # Enable NAT
    nat.enable = true;
    # Predictable interfaces
    usePredictableInterfaceNames = true;
    # Set smartdns server
    nameservers = [ "127.0.53.53" ];
    # Disable resolvconf
    # Otherwise NetworkManager would use resolvconf to update /etc/resolv.conf
    resolvconf.enable = false;
  };

  # Sops-Nix
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops.key";
    secrets = { passwd.neededForUsers = true; };
  };

  # Users
  users = {
    mutableUsers = true;
    users = {
      shadowrz = {
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.passwd.path;
        shell = pkgs.zsh;
        description = "羽心印音";
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
        packages = with pkgs; [
          blender_3_6 # Blender 3.6.* (Binary)
          hugo # Hugo
          libsForQt5.plasma-sdk # Plasma SDK
          konversation
          libreoffice-fresh # LibreOffice Fresh
          virt-viewer # Virt Viewer
          ffmpeg-full # FFmpeg
          keepassxc
          kdenlive
          libsForQt5.neochat
          fluffychat
          cinny-desktop
          yt-dlp
          logseq
          blanket
          vscode # VS Code
          renpy
          gimp # GIMP
          inkscape # Inkscape
          d-spy # D-Spy
          celluloid
          eclipses.eclipse-java
        ];
      };
    };
  };

  # Home Manager
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit (config) nur; };
    users.shadowrz = import ./shadowrz/home-configuration.nix;
  };

  # Misc
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ./overrides/package-overlay.nix) ];
  };

  # Libvirtd
  virtualisation = {
    waydroid.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        # Enable UEFI
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        # Enable virtual TPM support
        swtpm.enable = true;
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
      fastfetch
      # Graphical packages.
      papirus-icon-theme # Papirus
      phinger-cursors
      # Qt 5 tools
      libsForQt5.qttools.dev
      material-kwin-decoration # KWin material decoration
      adw-gtk3
      libsForQt5.krecorder
      # Plasma themes
      graphite-kde-theme
      # Virtiofsd
      virtiofsd
    ];
    # Link /share/zsh
    pathsToLink = [ "/share/zsh" ];
    # Set a NIX_BUILD_SHELL
    variables = let
      nix-build-shell = pkgs.writeScript "nix-build-shell" ''
        #!${pkgs.runtimeShell}
        # Remember the user shell.
        shell=$SHELL

        # nix-shell run this script as (shell) --rcfile $2
        rcfile="$2"
        source "$rcfile"

        # Run user shell.
        SHELL=$shell exec -a "$shell" "$shell"
      '';
    in {
      NIX_BUILD_SHELL = "${nix-build-shell}";
      VK_ICD_FILENAMES =
        "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";
    };
    plasma5.excludePackages = with pkgs; [
      okular
      khelpcenter
      konsole
      oxygen
      libsForQt5.print-manager
    ];
    # Manually configures a working /etc/resolv.conf
    # since we don't have anyone to update it
    etc."resolv.conf".text = ''
      nameserver 127.0.53.53
    '';
    # Persistent files
    persistence."/persist" = {
      directories = [ "/var" "/root" ];
      files = [ "/etc/machine-id" ];
      users = {
        shadowrz = {
          directories = [
            "Documents"
            "Downloads"
            "Pictures"
            "Projects"
            "Maildir"
            "Music"
            "Public"
            "Videos"
            ".android"
            ".cache"
            ".cargo"
            ".config"
            ".gnupg"
            ".local"
            ".logseq"
            ".mozilla"
            ".renpy"
            ".ssh"
            ".thunderbird"
            ".var"
            ".vscode"
          ];
          files = [ ".gtkrc-2.0" ];
        };
        root = {
          home = "/root";
          directories = [ ".cache/nix" ];
        };
      };
    };
  };

  # Fonts.
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      liberation_ttf # Liberation Fonts
      iosevka # Iosevka (Source Build)
      noto-fonts # Base Noto Fonts
      noto-fonts-cjk # CJK Noto Fonts
      noto-fonts-cjk-serif # Noto Serif CJK
      noto-fonts-emoji # Noto Color Emoji
      sarasa-gothic # Sarasa Gothic
      jost # Jost
    ];
    fontconfig = {
      defaultFonts = lib.mkForce {
        serif = [ "Noto Serif" "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
        monospace = [ "Iosevka Extended" ];
        emoji = [ "Noto Color Emoji" ];
      };
      subpixel.rgba = "rgb";
      localConf = builtins.readFile ./files/52-sarasa-fonts-after-iosevka.conf;
    };
  };

  services = {
    # Getty
    getty = {
      greetingLine = with config.system.nixos; ''
        Hanekokoro OS
        Configuration Revision = ${config.system.configurationRevision}

        Based on NixOS ${release} (${codeName})
        Revision = ${revision}
      '';
    };
    # Generate ZRAM
    zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd";
        zram-size = "ram";
      };
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      # SDDM
      displayManager = {
        # Plasma Wayland session works for me.
        defaultSession = "plasmawayland";
        sddm.enable = true;
      };
      desktopManager.plasma5 = {
        enable = true;
        runUsingSystemd = true;
      };
    };
    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
    # Smartdns
    smartdns = {
      enable = true;
      settings = with pkgs; {
        conf-file = [
          "${./files/accelerated-domains.china.smartdns.conf}"
          "${./files/apple.china.smartdns.conf}"
          "${./files/google.china.smartdns.conf}"
          "${./files/bogus-nxdomain.china.smartdns.conf}"
        ];
        bind = [ "127.0.53.53:53" ];
        server = [
          # Local Dnsmasq pushed by NetworkManager
          "127.0.0.1 -group china -exclude-default-group"
        ];
        server-https = [
          # https://www.dnspod.cn/Products/publicdns
          "https://doh.pub/dns-query -group china -exclude-default-group -tls-host-verify doh.pub"
          # https://quad9.net/service/service-addresses-and-features/
          "https://9.9.9.9/dns-query -tls-host-verify dns.quad9.net"
          "https://149.112.112.112/dns-query -tls-host-verify dns.quad9.net"
        ];
        # (XXX)
        nameserver = [
          "/github.com/china"
          "/codeload.github.com/china"
          "/ssh.github.com/china"
          "/api.github.com/china"
          "/cache.nixos.org/china"
        ];
        speed-check-mode = "tcp:443,tcp:80";
        # Add log
        log-level = "info";
        log-file = "/var/log/smartdns.log";
      };
    };
    # pykms
    pykms.enable = true;
    # Flatpak
    flatpak.enable = true;
  };

  # System programs
  programs = {
    # Disable building /etc/nanorc
    nano.syntaxHighlight = false;
    less = { enable = true; };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };
    # Dconf
    dconf.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      histFile = "$HOME/.cache/zsh_history";
      autosuggestions = { enable = true; };
      syntaxHighlighting = { enable = true; };
      histSize = 50000;
      setOptions = [
        # History related options.
        "HIST_VERIFY"
        "HIST_FIND_NO_DUPS"
        "HIST_SAVE_NO_DUPS"
        "HIST_REDUCE_BLANKS"
        # Completion related options.
        "ALWAYS_TO_END"
        "LIST_PACKED"
        "COMPLETE_IN_WORD"
        "MENU_COMPLETE"
        # Navigation related options.
        "PUSHD_IGNORE_DUPS"
        "PUSHD_SILENT"
        "PUSHD_TO_HOME"
        "AUTO_PUSHD"
        # Globbing related options.
        "EXTENDED_GLOB"
        "MAGIC_EQUAL_SUBST"
        # I/O related options.
        "NO_CLOBBER"
        "INTERACTIVE_COMMENTS"
        "RC_QUOTES"
        "CORRECT"
        "NO_FLOW_CONTROL"
        # Remove any RPROMPT after executing command.
        "TRANSIENT_RPROMPT"
        # Don't beep at all.
        "NO_BEEP"
      ];
      interactiveShellInit = builtins.readFile ./files/zshrc;
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
    # Starship (Global)
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./files/starship.toml);
    };
    kdeconnect.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    # Bluetooth
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        intel-compute-runtime
      ];
    };
  };

  # Enable sounds
  sound.enable = true;

  xdg.portal = {
    enable = true;
    # Enable GTK portal
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Rtkit
  security.rtkit.enable = true;

  # Disable all HTML documentations.
  documentation.doc.enable = lib.mkForce false;

  i18n = {
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
    # Fcitx 5
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
    };
  };

  # Kill generated Systemd service for Fcitx 5
  # Required to make sure KWin can bring a Fcitx 5 up to support Wayland IME protocol
  systemd.user.services.fcitx5-daemon = lib.mkForce { };

  # DO NOT FIDDLE WITH THIS VALUE !!!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  # Before changing this value (which you shouldn't do unless you have
  # REALLY NECESSARY reason to do this) read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  # and release notes, SERIOUSLY.
  system.stateVersion = "23.05"; # Did you read the comment?
}
