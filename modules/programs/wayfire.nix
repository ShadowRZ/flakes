{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.wayfire;
in {
  options.programs.wayfire = {
    enable = mkEnableOption ''
      Wayfire, the 3D Wayland compositor.'';
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ wayfire wcm ];
    };
    security.polkit.enable = true;
    hardware.opengl.enable = mkDefault true;
    # To make a Wayfire session available if a display manager like SDDM is enabled:
    services.xserver.displayManager.session = [
      {
        manage = "window";
        name = "wayfire";
        start = ''
          ${pkgs.wayfire}/bin/wayfire
        '';
      }
    ];
    programs.xwayland.enable = mkDefault true;
    # For screen sharing (this option only has an effect with xdg.portal.enable):
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  meta.maintainers = with lib.maintainers; [ primeos colemickens ];
}
