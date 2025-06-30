{
  flake.modules.homeManager = {
    desktop =
      { pkgs, ... }:
      {
        programs.mpv = {
          enable = true;
          config = {
            # OSD configs.
            osd-font = "Iosevka Aile";
            osd-bar = false;
            border = true;

            # Disable builtin OSC
            osc = false;

            # Subtitles.
            sub-align-x = "left";
            sub-font-size = 36;
            sub-justify = "auto";
            sub-font = "Iosevka Aile";
            sub-border-size = 1;
            sub-border-color = "#C0808080";
            sub-color = "#FF6699";

            osd-border-size = 1;
            osd-border-color = "#C0808080";

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
            console = {
              font = "Hanekokoro Mono";
              font_size = 24;
            };
            stats = {
              font = "Iosevka Aile";
              font_mono = "Hanekokoro Mono-E";
            };
            uosc = {
              timeline_size = 24;
              timeline_style = "bar";
              scale_fullscreen = 1;
              text_border = 0.5;
              controls = "menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality,gap,space,shuffle,loop-playlist,loop-file,gap,prev,items,next,gap,fullscreen";
              refine = "text_width";
            };
          };
          profiles = {
            bilibili = {
              profile-desc = "[BiliBili] Videos";
              profile-cond = "path:match('https://www.bilibili.com')~=nil or path:match('https://bilibili.com')~=nil";
              profile-restore = "copy";
              referrer = "https://www.bilibili.com/";
              ytdl-raw-options = "cookies-from-browser=firefox,sub-lang=[all,-danmaku],write-sub=";
            };
          };
          scripts = with pkgs.mpvScripts; [
            mpris
            uosc
          ];
        };
      };
  };
}
