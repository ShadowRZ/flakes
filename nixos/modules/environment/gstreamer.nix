{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gstreamer
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
    gst-vaapi
  ];
}
