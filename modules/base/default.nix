{
  flake.modules.nixos = {
    base =
      { pkgs, ... }:
      {
        environment = {
          defaultPackages = [ ];
          systemPackages = with pkgs; [
            dnsutils
            pciutils
            usbutils
            lsof
            strace
            file
            gdu
            wget
            tree
            unzip
            p7zip
            unar
            man-pages
          ];
        };

        services.userborn.enable = true;

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
      };
  };
}
