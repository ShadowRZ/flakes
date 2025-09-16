{
  hanekokoro = {
    nixos = {
      herrscher-seele = {
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
    nix-on-droid = {
      name = "akasha";
      system = "aarch64-linux";
      modules = [
        "base"
        "nix"
        "dev"
        "shell"
      ];
    };
  };
}
