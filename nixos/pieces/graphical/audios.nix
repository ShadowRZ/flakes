{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ardour # Ardour
    lmms # LMMS
    muse # MusE
    qtractor # Qtractor
    sonic-pi # Sonic Pi
    zynaddsubfx # ZynAddSubFX
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
