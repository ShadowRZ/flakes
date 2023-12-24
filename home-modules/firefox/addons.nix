{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }: {
  "copy-linktab-name-and-url" = buildFirefoxXpiAddon {
    pname = "copy-linktab-name-and-url";
    version = "2.2";
    addonId = "copylinknameandurl@livemylife.cn";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/1167172/copy_linktab_name_and_url-2.2.xpi";
    sha256 = "c3c8fde05d7923f2f011c189045c82ac877db43f0a57c31f5e38849cbf4f8f0d";
    meta = with lib; {
      homepage = "https://code.google.com/p/copy-link-or-tab-name-and-url/";
      description = ''
        Copy the name and URL of a link or a Tab.
        复制链接或标签页的名称和地址'';
      license = licenses.bsd2;
      mozPermissions = [
        "activeTab"
        "clipboardWrite"
        "contextMenus"
        "storage"
        "tabs"
        "<all_urls>"
      ];
      platforms = platforms.all;
    };
  };
  "custom-scrollbars" = buildFirefoxXpiAddon {
    pname = "custom-scrollbars";
    version = "4.2.2";
    addonId = "customscrollbars@computerwhiz";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/4104831/custom_scrollbars-4.2.2.xpi";
    sha256 = "832dfd78ee755df40fad2b458c931754b9111ee46e0418de2616baecbc012e24";
    meta = with lib; {
      homepage = "https://addons.wesleybranton.com/addon/custom-scrollbars/";
      description = "Give Firefox a personal touch with customized scrollbars!";
      license = licenses.mpl20;
      mozPermissions = [
        "storage"
        "<all_urls>"
        "*://addons.wesleybranton.com/addon/custom-scrollbars/*"
        "*://customscrollbars.com/*"
      ];
      platforms = platforms.all;
    };
  };
  "emoji-sav" = buildFirefoxXpiAddon {
    pname = "emoji-sav";
    version = "3.20";
    addonId = "emoji@saveriomorelli.com";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/4195786/emoji_sav-3.20.xpi";
    sha256 = "cac9a6d31eae27a273da23a84a66a9e2ba54e8b5edab421c97ba009b706e5f1a";
    meta = with lib; {
      homepage = "https://www.emojiaddon.com";
      description = ''
        It permits just with a single click to copy an emoji.
        There is a search-box and the "Most used emojis" section (the first one).

        If you want to send feedback or report bug, please contact me: <a href="https://prod.outgoing.prod.webservices.mozgcp.net/v1/b753c67704f26ea23ad2ea0e6cdf84584259e0610aff7861a2c72976219974ed/https%3A//www.emojiaddon.com/help" rel="nofollow">https://www.emojiaddon.com/help</a>'';
      license = licenses.mpl20;
      mozPermissions = [ "storage" ];
      platforms = platforms.all;
    };
  };
  "foxyimage" = buildFirefoxXpiAddon {
    pname = "foxyimage";
    version = "1.7";
    addonId = "foxyimage@eros.man";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/1111896/foxyimage-1.7.xpi";
    sha256 = "f529d1fc38bcfb0e564bab34a1f2ff36faadd5dc1bcf744fd45d39457d0b11be";
    meta = with lib; {
      description = "Collection of Image Related Actions";
      license = licenses.mpl20;
      mozPermissions = [
        "activeTab"
        "clipboardWrite"
        "contextMenus"
        "cookies"
        "downloads"
        "notifications"
        "storage"
        "<all_urls>"
      ];
      platforms = platforms.all;
    };
  };
  "measure-it" = buildFirefoxXpiAddon {
    pname = "measure-it";
    version = "2.2.0";
    addonId = "{79b2e4de-8fb4-4ccc-b9f6-362ac2fb74b2}";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3155605/measure_it-2.2.0.xpi";
    sha256 = "0d6bbdc887d8fa2c59115336209faab420c33d2801ccef96f71322975d966274";
    meta = with lib; {
      homepage = "https://github.com/tsl143/measure-it";
      description =
        "Draw a ruler across any webpage to check the width, height, or alignment of page elements in pixels.";
      license = licenses.gpl3;
      mozPermissions = [ "activeTab" "storage" ];
      platforms = platforms.all;
    };
  };
  "textarea-cache" = buildFirefoxXpiAddon {
    pname = "textarea-cache";
    version = "4.6.0";
    addonId = "textarea-cache-lite@wildsky.cc";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/4205511/textarea_cache-4.6.0.xpi";
    sha256 = "9e75b66e008a4193b5090a32b6334051e5f63242872f600ee305e74851e2742e";
    meta = with lib; {
      description =
        "Allows to save automatically the content in a text input field.";
      license = licenses.mit;
      mozPermissions =
        [ "storage" "clipboardWrite" "menus" "alarms" "<all_urls>" ];
      platforms = platforms.all;
    };
  };
  "tranquility-reader" = buildFirefoxXpiAddon {
    pname = "tranquility-reader";
    version = "3.0.24";
    addonId = "tranquility@ushnisha.com";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3934978/tranquility_1-3.0.24.xpi";
    sha256 = "15b32eb8d05f8c972dc402f037e3b9d9152a6eb42d8ffc64fcf6a588a3486857";
    meta = with lib; {
      homepage = "https://github.com/ushnisha/tranquility-reader-webextensions";
      description =
        "Tranquility Reader improves the readability of web articles by removing unnecessary elements like ads, images, social sharing widgets, and other distracting fluff.";
      license = licenses.gpl3;
      mozPermissions =
        [ "<all_urls>" "activeTab" "storage" "alarms" "contextMenus" ];
      platforms = platforms.all;
    };
  };
}
