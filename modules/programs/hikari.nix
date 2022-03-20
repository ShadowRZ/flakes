{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.hikari;
  hikariSession = pkgs.stdenvNoCC.mkDerivation { 
    name = "hikari-session";
    phases = ["installPhase"];
    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/hikari.desktop << EOF
      [Desktop Entry]
      Name=Hikari
      Comment=Stacking compositor with tilling capabilities
      Exec=${pkgs.shadowrz.subreaper} ${pkgs.hikari}/bin/hikari
      Type=Application
      EOF
    '';
    passthru.providedSessions = ["hikari"];
  };
in {
  options.programs.hikari = {
    enable = mkEnableOption ''
      Hikari Wayland compositor.'';
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ hikari ];
    };
    security.polkit.enable = true;
    hardware.opengl.enable = mkDefault true;
    # To make a Hikari session available if a display manager like SDDM is enabled:
    services.xserver.displayManager.sessionPackages = [ hikariSession ];
    programs.xwayland.enable = mkDefault true;
    # For screen sharing (this option only has an effect with xdg.portal.enable):
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
