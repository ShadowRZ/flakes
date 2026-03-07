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

            hwdec = "vaapi";
            vo = "gpu-next";
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
            bililive = {
              profile-desc = "[BiliBili] Livestream";
              profile-cond = "path:match('https://live.bilibili.com')~=nil";
              profile-restore = "copy";
              ytdl-raw-options = "cookies-from-browser=firefox";
              ytdl-format = "best[protocol=https]";
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
