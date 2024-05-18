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
    # System profile
    ./nixos/profiles/system/mika-honey.nix
    # Disko config
    ./nixos/profiles/system/disko/mika-honey.nix
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
  ];
  mononekomi = [
    # Modules
    ./nixos/modules
    ./nixos/modules/boot-systemd.nix
    ./nixos/modules/graphical
    ./nixos/modules/networking
    ./nixos/modules/networking/networkmanager.nix
    ./nixos/modules/user-profiles.nix
    ./nixos/profiles/plasma-desktop.nix
    # System profile
    ./nixos/profiles/system/mononekomi.nix
    # Disko config
    ./nixos/profiles/system/disko/mononekomi.nix
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
  ];
}