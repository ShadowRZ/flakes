{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "custom-scrollbars" = buildFirefoxXpiAddon {
      pname = "custom-scrollbars";
      version = "4.2.2";
      addonId = "customscrollbars@computerwhiz";
      url = "https://addons.mozilla.org/firefox/downloads/file/4104831/custom_scrollbars-4.2.2.xpi";
      sha256 = "832dfd78ee755df40fad2b458c931754b9111ee46e0418de2616baecbc012e24";
      meta = with lib;
      {
        homepage = "https://addons.wesleybranton.com/addon/custom-scrollbars/";
        description = "Give Firefox a personal touch with customized scrollbars!";
        license = licenses.mpl20;
        platforms = platforms.all;
        };
      };
    "measure-it" = buildFirefoxXpiAddon {
      pname = "measure-it";
      version = "2.2.0";
      addonId = "{79b2e4de-8fb4-4ccc-b9f6-362ac2fb74b2}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3155605/measure_it-2.2.0.xpi";
      sha256 = "0d6bbdc887d8fa2c59115336209faab420c33d2801ccef96f71322975d966274";
      meta = with lib;
      {
        homepage = "https://github.com/tsl143/measure-it";
        description = "Draw a ruler across any webpage to check the width, height, or alignment of page elements in pixels.";
        license = licenses.gpl3;
        platforms = platforms.all;
        };
      };
    "redirector" = buildFirefoxXpiAddon {
      pname = "redirector";
      version = "3.5.3";
      addonId = "redirector@einaregilsson.com";
      url = "https://addons.mozilla.org/firefox/downloads/file/3535009/redirector-3.5.3.xpi";
      sha256 = "eddbd3d5944e748d0bd6ecb6d9e9cf0e0c02dced6f42db21aab64190e71c0f71";
      meta = with lib;
      {
        homepage = "http://einaregilsson.com/redirector/";
        description = "Automatically redirects to user-defined urls on certain pages";
        license = licenses.mit;
        platforms = platforms.all;
        };
      };
    }