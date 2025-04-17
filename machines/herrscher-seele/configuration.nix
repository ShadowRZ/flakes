{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Core fragments
    ./fragments/disk-layout.nix
    ./fragments/hardware-configuration.nix
    # Secrets
    ./secrets
    # Machine specific modules
    ./modules/networking.nix
    ./modules/preservation.nix
    ./modules/virtualisation.nix
    # Users
    ./users/root.nix
    ./users/shadowrz.nix
  ];

  services.getty.greetingLine = with config.system.nixos; ''
    NixOS ${release} (${codeName})
    https://github.com/NixOS/nixpkgs/tree/${revision}

    \e{lightmagenta}Codename Hanekokoro
    https://github.com/ShadowRZ/flakes/tree/${config.system.configurationRevision}
  '';

  # Kernel
  boot = {
    loader.timeout = 0;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    # Set path for Lanzaboote
    lanzaboote.pkiBundle = "${config.users.users.shadowrz.home}/Documents/Secureboot";
  };

  # System programs
  programs = {
    adb.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      enableLsColors = false;
    };
    ssh = {
      startAgent = true;
    };
    # Steam
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraArgs = "-forcedesktopscaling 1.5";
      };
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };

  environment = {
    systemPackages = [
      # For FirefoxPWA
      pkgs.firefoxpwa
      # Kvantum
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.kdePackages.qtstyleplugin-kvantum

      pkgs.papirus-icon-theme

      pkgs.plasma-panel-colorizer
    ];

    variables = {
      VK_ICD_FILENAMES = "${pkgs.mesa}/share/vulkan/icd.d/intel_icd.x86_64.json";
      GSK_RENDERER = "gl";
    };
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
    system76-scheduler.enable = true;
    # Userborn
    userborn.enable = true;
    # SDDM
    displayManager.sddm.settings = {
      Theme = {
        Font = "Space Grotesk";
        CursorTheme = "BreezeX-RosePineDawn-Linux";
        CursorSize = 32;
      };
    };
  };

  programs.kde-pim.enable = false;

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

  users.mutableUsers = false;
  powerManagement.powertop.enable = true;

  system.etc.overlay = {
    enable = true;
    mutable = true;
  };

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
