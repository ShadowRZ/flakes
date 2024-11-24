{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Global Flake Inputs
    inputs.home-manager.nixosModules.home-manager
    inputs.nur.nixosModules.nur
    inputs.nix-indexdb.nixosModules.nix-index
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
  };

  boot = {
    tmp.useTmpfs = true;
    enableContainers = lib.mkDefault false;
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  networking = {
    # Disable global DHCP
    useDHCP = false;
    # Disable firewall by default.
    firewall.enable = lib.mkDefault false;
    # Enable NAT
    nat.enable = true;
    # Predictable interfaces
    usePredictableInterfaceNames = true;
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

  # System programs
  programs = {
    # Disable Nano by default.
    nano.enable = lib.mkDefault false;
    # In github:Guanran928/nixos-sensible Vim is set as default editor without
    # programs.vim.enable = true which isn't expected to work.
    # Workaround this.
    # The downside is that NixOS configurations must override with lib.mkForce
    vim.defaultEditor = false;
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
    supportedLocales = [ "all" ];
  };

  services.dbus.implementation = "broker";
}
