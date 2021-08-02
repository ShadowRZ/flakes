{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # VA-API.
    vaapiIntel
    intel-gpu-tools
    libva-utils
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs; [ vaapiIntel ];
}
