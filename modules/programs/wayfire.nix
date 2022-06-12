{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.wayfire;
  wayfireSession = pkgs.stdenvNoCC.mkDerivation {
    name = "wayfire-session";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/wayfire.desktop << EOF
      [Desktop Entry]
      Name=Wayfire
      Exec=${pkgs.shadowrz.wl-session} ${pkgs.wayfire}/bin/wayfire
      Icon=
      Type=Application
      DesktopNames=Wayfire
      EOF
    '';
    passthru.providedSessions = [ "wayfire" ];
  };
in {
  options.programs.wayfire = {
    enable = mkEnableOption "Wayfire, the 3D Wayland compositor.";
  };

  config = mkIf cfg.enable {
    environment = { systemPackages = with pkgs; [ wayfire wcm ]; };
    security.polkit.enable = true;
    hardware.opengl.enable = mkDefault true;
    # To make a Wayfire session available if a display manager like SDDM is enabled:
    services.xserver.displayManager.sessionPackages = [ wayfireSession ];
    programs.xwayland.enable = mkDefault true;
    # For screen sharing (this option only has an effect with xdg.portal.enable):
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
