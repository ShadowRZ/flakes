{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.labwc;
  wayfireSession = pkgs.stdenvNoCC.mkDerivation {
    name = "labwc-session";
    phases = ["installPhase"];
    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/labwc.desktop << EOF
      [Desktop Entry]
      Name=layfire
      Exec=${pkgs.labwc}/bin/labwc
      Type=Application
      Comment=A wayland stacking compositor
      EOF
    '';
    passthru.providedSessions = ["labwc"];
  };
in {
  options.programs.labwc = {
    enable = mkEnableOption ''Labwc.'';
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ labwc ];
    };
    security.polkit.enable = true;
    hardware.opengl.enable = mkDefault true;
    # To make a Labwc session available if a display manager like SDDM is enabled:
    services.xserver.displayManager.sessionPackages = [ labwcSession ];
    programs.xwayland.enable = mkDefault true;
    # For screen sharing (this option only has an effect with xdg.portal.enable):
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
