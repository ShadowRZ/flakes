{ pkgs, modulesPath, ... }:

{
  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
  ];

  services.desktopManager.plasma6.enable = true;

  # Automatically login as nixos.
  services.displayManager = {
    sddm.enable = true;
    autoLogin = {
      enable = true;
      user = "nixos";
    };
  };

  environment.systemPackages = with pkgs; [
    # Graphical text editor
    kdePackages.kate
  ];

  system.activationScripts.installerDesktop = let

    # Comes from documentation.nix when xserver and nixos.enable are true.
    manualDesktopFile = "/run/current-system/sw/share/applications/nixos-manual.desktop";

    homeDir = "/home/nixos/";
    desktopDir = homeDir + "Desktop/";

  in ''
    mkdir -p ${desktopDir}
    chown nixos ${homeDir} ${desktopDir}

    ln -sfT ${manualDesktopFile} ${desktopDir + "nixos-manual.desktop"}
    ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    ln -sfT ${pkgs.plasma5Packages.konsole}/share/applications/org.kde.konsole.desktop ${desktopDir + "org.kde.konsole.desktop"}
  '';

}
