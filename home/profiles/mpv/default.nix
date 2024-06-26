{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      # OSD configs.
      osd-font = "Iosevka Aile Minoko";
      osd-font-size = 40;
      osd-on-seek = "msg-bar";

      # Enable builtin OSC
      osc = true;

      # Subtitles.
      sub-align-x = "right";
      sub-font-size = 45;
      sub-justify = "auto";
      sub-font = "Space Grotesk";
      sub-border-size = 3;
      sub-color = "#DE8148";

      # Prefer hardware decoding.
      hwdec = "vulkan,vaapi";

      gpu-hwdec-interop = "vaapi";
      vo = "gpu-next";
      tone-mapping = "auto";
      hwdec-codecs = "all";
      sub-auto = "fuzzy";
      vd-lavc-dr = "yes";
      replaygain = "album";
      gpu-api = "vulkan";
      native-keyrepeat = true;
    };
    scriptOpts = {
      osc = {
        scalewindowed = 1.5;
        scalefullscreen = 1.5;
        vidscale = false;
        visibility = "always";
        seekbarstyle = "knob";
        seekrangestyle = "slider";
      };
      console = {
        font = "Iosevka Minoko";
        font_size = 22;
      };
      stats = {
        font = "Iosevka Aile Minoko";
        font_mono = "Iosevka Minoko-E";
      };
    };
    scripts = with pkgs.mpvScripts; [mpris];
  };
}
