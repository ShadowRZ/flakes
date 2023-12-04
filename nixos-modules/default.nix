# Mostly identical configs across almost all machines I'll ever have.

{ config, pkgs, lib, inputs, ... }: {

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
        "https://shadowrz.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "berberman.cachix.org-1:UHGhodNXVruGzWrwJ12B1grPK/6Qnrx2c3TjKueQPds="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
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

  # Misc
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.blender.overlays.default
      inputs.berberman.overlays.default
      inputs.emacs-overlay.overlays.default
      (final: prev: {
        # lilydjwg/subreap
        zsh = prev.zsh.overrideAttrs (attrs: {
          patches = (attrs.patches or [ ]) ++ [ ./patches/zsh-subreap.patch ];
        });
      })
    ];
  };

  # Configuration revision.
  system.configurationRevision =
    lib.mkIf (inputs.self ? rev) inputs.self.rev;

  # Pin NIX_PATH
  nix.settings.nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.registry = {
    p.flake = inputs.self;
    nixpkgs.flake = inputs.nixpkgs;
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
      # Graphical packages.
      papirus-icon-theme # Papirus
      graphite-cursors
    ];
    # Link /share/zsh
    pathsToLink = [ "/share/zsh" ];
    variables = {
      VK_ICD_FILENAMES =
        "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";
    };
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
    extraInit = ''
      # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#KDE_Plasma
      export -n GTK_IM_MODULE QT_IM_MODULE
      unset GTK_IM_MODULE QT_IM_MODULE
    '';
    plasma5.excludePackages = with pkgs; [
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
  };

  # Fonts.
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      iosevka # Iosevka (Source Build)
      noto-fonts # Base Noto Fonts
      noto-fonts-cjk # CJK Noto Fonts
      noto-fonts-cjk-serif # Noto Serif CJK
      noto-fonts-emoji # Noto Color Emoji
      sarasa-gothic # Sarasa Gothic
      jost # Jost
      config.nur.repos.xddxdd.hoyo-glyphs
      # Iosevka Builds
      config.nur.repos.shadowrz.iosevka-minoko
      config.nur.repos.shadowrz.iosevka-minoko-term
      config.nur.repos.shadowrz.iosevka-aile-minoko
      config.nur.repos.shadowrz.iosevka-minoko-e
    ];
    fontconfig = {
      defaultFonts = lib.mkForce {
        serif = [ "Noto Serif" "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
        monospace = [ "Iosevka Minoko-E" ];
        emoji = [ "Noto Color Emoji" ];
      };
      subpixel.rgba = "rgb";
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <!-- Add Sarasa Mono SC for Iosevka based fonts -->
          <match target="pattern">
            <test name="family" compare="contains">
              <string>Iosevka</string>
            </test>
            <edit binding="strong" mode="append" name="family">
              <string>Sarasa Mono SC</string>
            </edit>
          </match>
        </fontconfig>
      '';
      cache32Bit = true;
    };
  };

  services = {
    # Smartdns
    smartdns = {
      enable = true;
      settings = {
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
  };

  # System programs
  programs = {
    nano.enable = false;
    # Dconf
    dconf.enable = true;
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

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit (config) nur; };
  };

  # Rtkit
  security.rtkit.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?
}
