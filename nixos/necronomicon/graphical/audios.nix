{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ardour # Ardour
    sonic-visualiser # Sonic Visualiser
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
