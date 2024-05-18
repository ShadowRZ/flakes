{
    mika-honey = [
      # Modules
      ./nixos/modules
      ./nixos/modules/boot-systemd.nix
      ./nixos/modules/graphical
      ./nixos/modules/networking
      ./nixos/modules/networking/networkmanager.nix
      ./nixos/modules/user-profiles.nix
      ./nixos/modules/vmos-guest.nix
      ./nixos/profiles/plasma-desktop.nix
      # Disko config
      ./nixos/disko/btrfs-subvolume.nix
      # System profile
      ./nixos/profiles/system/mika-honey.nix
      {
        home-manager = {
          sharedModules = [ ./home ];
          users = {
            shadowrz.imports =
              [ ./home/env-extras.nix ./home/graphical.nix ./home/firefox ];
            root = { };
          };
        };
      }
    ]
}