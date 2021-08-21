{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ardour # Ardour
    lmms # LMMS
    qtractor # Qtractor
    sonic-pi # Sonic Pi
    zynaddsubfx # ZynAddSubFX
    sonic-visualiser # Sonic Visualiser
    vmpk # VMPK
  ];

  # rtkit
  security.rtkit.enable = true;

  # PipeWire
  services.pipewire = {
    enable = true;
    # ALSA
    alsa.enable = true;
    # PulseAudio
    pulse.enable = true;
    # JACK
    jack.enable = true;
  };
}
