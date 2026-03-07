{
  hanekokoro = {
    nixos = {
      mimeow-coffees = {
        system = "x86_64-linux";
        modules = [
          "base"
          "bluetooth"
          "desktop"
          "dev"
          "dev-desktop"
          "fwupd"
          "gnupg"
          "hardening"
          "nix"
          "plasma-desktop"
          "shell"
          "sound"
          "steam"
          "root"
          "shadowrz"
        ];
      };
    };
  };
}
