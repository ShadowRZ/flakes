{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.labwc;
  labwcSession = pkgs.stdenvNoCC.mkDerivation {
    name = "labwc-session";
    phases = ["installPhase"];
    installPhase = let
      runner = pkgs.shadowrz.mkSystemdRun "${pkgs.labwc}/bin/labwc";
    in ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/labwc.desktop << EOF
      [Desktop Entry]
      Name=layfire
      Exec=${runner}
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
