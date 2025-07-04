{
  flake.modules.nixos = {
    sound = {
      services = {
        pulseaudio.enable = false;
        # Pipewire
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          # If you want to use JACK applications, uncomment this
          jack.enable = true;
        };
      };
    };
  };
}
