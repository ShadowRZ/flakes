{ inputs, ... }:
{
  flake.modules.nixos."hosts/mimeow-coffees" =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.nixos-sensible.nixosModules.zram ];

      hanekokoro.nixos.user = "shadowrz";

      boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

      time.timeZone = "Asia/Shanghai";

      i18n = {
        defaultLocale = "C.UTF-8";
        # Build all Glibc supported locales as defined in:
        # https://sourceware.org/git/?p=glibc.git;a=blob;f=localedata/SUPPORTED
        supportedLocales = [
          "all"
        ];
      };

      powerManagement = {
        enable = true;
        powertop.enable = true;
        cpuFreqGovernor = lib.mkDefault "powersave";
      };

      services.orca.enable = false;
      services.speechd.enable = false;

      services.userborn.enable = true;
      services.zerotierone.enable = true;

      security.pam.loginLimits = [
        {
          domain = "*";
          type = "-";
          item = "memlock";
          value = "unlimited";
        }
      ];

      users.mutableUsers = false;

      system.etc.overlay = {
        enable = true;
        mutable = true;
      };

      documentation = {
        enable = true;
        doc.enable = false;
        info.enable = false;

        # Enable man-db
        man.man-db.enable = true;
      };

      system = {
        nixos-init.enable = true;
        tools = {
          nixos-option.enable = true;
          nixos-version.enable = false;
          nixos-generate-config.enable = false;
        };
      };

      # Increase open files for all users
      systemd.user.extraConfig = ''
        DefaultLimitNOFILE=524288:524288
      '';

      services.journald.extraConfig = ''
        SystemMaxUse=100M
        MaxFileSec=3day
      '';

      services.nscd.enableNsncd = true;

      environment = {
        systemPackages = with pkgs; [
          # keep-sorted start
          dnsutils
          file
          gdu
          lsof
          man-pages
          p7zip
          pciutils
          strace
          tree
          unar
          unzip
          usbutils
          wget
          # keep-sorted end
        ];
      };

      nix.settings.substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
      ];

      hanekokoro.nixos.preservation.directories = [
        "/var/lib/systemd"
        "/var/lib/zerotier-one"
      ];
    };
}
