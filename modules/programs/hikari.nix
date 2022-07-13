{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.hikari;
  hikariSession = pkgs.stdenvNoCC.mkDerivation {
    name = "hikari-session";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/hikari.desktop << EOF
      [Desktop Entry]
      Name=Hikari
      Comment=Stacking compositor with tilling capabilities
      Exec=${pkgs.shadowrz.wl-session} ${pkgs.hikari}/bin/hikari
      Type=Application
      EOF
    '';
    passthru.providedSessions = [ "hikari" ];
  };
in {
  options.programs.hikari = {
    enable = mkEnableOption "Hikari Wayland compositor.";
  };

  config = mkIf cfg.enable {
    environment = { systemPackages = with pkgs; [ hikari ]; };
    security.polkit.enable = true;
    security.pam.services.hikari-unlocker = {
      # Upstream PAM rules
      text = "auth include login";
    };
    # SUID required
    security.wrappers.hikari-unlocker = {
      owner = "root";
      group = "root";
      setuid = true;
      source = "${pkgs.hikari}/bin/hikari-unlocker";
    };
    hardware.opengl.enable = mkDefault true;
    # To make a Hikari session available if a display manager like SDDM is enabled:
    services.xserver.displayManager.sessionPackages = [ hikariSession ];
    programs.xwayland.enable = mkDefault true;
  };
}
