{
  flake.modules.homeManager = {
    desktop =
      { pkgs, ... }:
      {
        programs.obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-3d-effect
            obs-vkcapture
            obs-gstreamer
            input-overlay
            obs-text-pthread
            obs-gradient-source
          ];
        };
      };
  };
}
