{
  hanekokoro.nixos = {
    mimeow-coffees = {
      modules = [
        # keep-sorted start
        "base"
        "desktop"
        "desktop/dev"
        "desktop/dev/android"
        "desktop/niri"
        "desktop/steam"
        "dev"
        "hardening"
        "hardware/bluetooth"
        "hardware/fwupd"
        "hardware/gpu/intel"
        "hardware/gpu/nvidia"
        "hardware/sound"
        "hardware/thunderbolt"
        "network"
        "network/networkmanager"
        "network/throne"
        "nix"
        "preservation"
        "security/gnupg"
        "security/lanzaboote"
        "security/pam-fido2"
        "shell"
        "terminal/kitty"
        "terminal/kmscon"
        "users/root"
        "users/shadowrz"
        "virt/libvirt"
        "virt/podman"
        "virt/waydroid"
        # keep-sorted end
      ];
    };
  };
}
