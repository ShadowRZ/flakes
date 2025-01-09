{
  buildFirefoxXpiAddon,
  lib,
  stdenv,
}:
{
  "copy-linktab-name-and-url" = buildFirefoxXpiAddon {
    pname = "copy-linktab-name-and-url";
    version = "2.3resigned1";
    addonId = "copylinknameandurl@livemylife.cn";
    url = "https://addons.mozilla.org/firefox/downloads/file/4270178/copy_linktab_name_and_url-2.3resigned1.xpi";
    sha256 = "406809b45ca68f087f5c41365cd391f3cd5dbddb182bd4b063b09bc8d44e4166";
    meta = with lib; {
      homepage = "https://code.google.com/p/copy-link-or-tab-name-and-url/";
      description = "Copy the name and URL of a link or a Tab.\n复制链接或标签页的名称和地址";
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
    version = "4.4";
    addonId = "customscrollbars@computerwhiz";
    url = "https://addons.mozilla.org/firefox/downloads/file/4388391/custom_scrollbars-4.4.xpi";
    sha256 = "a15a5f9198da1c67339f5f76eadf3eccde235ac53eea617b9182b9dc270f8a96";
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
    version = "3.23.1.2";
    addonId = "emoji@saveriomorelli.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/4407001/emoji_sav-3.23.1.2.xpi";
    sha256 = "cebceedb8b72c9c4064fa787e7a4e25d6afd41e7060cd3a2173b6c387e0ab380";
    meta = with lib; {
      homepage = "https://www.emojiaddon.com";
      description = "It permits just with a single click to copy an emoji.\r\nThere is a search-box and the \"Most used emojis\" section (the first one).\r\n\r\nIf you want to send feedback or report bug, please contact me";
      license = licenses.mpl20;
      mozPermissions = [ "storage" ];
      platforms = platforms.all;
    };
  };
  "foxyimage" = buildFirefoxXpiAddon {
    pname = "foxyimage";
    version = "1.8resigned1";
    addonId = "foxyimage@eros.man";
    url = "https://addons.mozilla.org/firefox/downloads/file/4272296/foxyimage-1.8resigned1.xpi";
    sha256 = "58ce98c465651f7308aea395b8082f6ae9d68d7d7e6fde2ca56375e61d705805";
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
    url = "https://addons.mozilla.org/firefox/downloads/file/3155605/measure_it-2.2.0.xpi";
    sha256 = "0d6bbdc887d8fa2c59115336209faab420c33d2801ccef96f71322975d966274";
    meta = with lib; {
      homepage = "https://github.com/tsl143/measure-it";
      description = "Draw a ruler across any webpage to check the width, height, or alignment of page elements in pixels.";
      license = licenses.gpl3;
      mozPermissions = [
        "activeTab"
        "storage"
      ];
      platforms = platforms.all;
    };
  };
  "pwas-for-firefox" = buildFirefoxXpiAddon {
    pname = "pwas-for-firefox";
    version = "2.13.1";
    addonId = "firefoxpwa@filips.si";
    url = "https://addons.mozilla.org/firefox/downloads/file/4383345/pwas_for_firefox-2.13.1.xpi";
    sha256 = "aff2b25a0d4068c0e77776e624404219e3355735cc8d13a160bb77ebb9412e4d";
    meta = with lib; {
      homepage = "https://github.com/filips123/PWAsForFirefox";
      description = "A tool to install, manage and use Progressive Web Apps (PWAs) in Mozilla Firefox";
      license = licenses.mpl20;
      mozPermissions = [
        "http://*/*"
        "https://*/*"
        "nativeMessaging"
        "notifications"
        "storage"
      ];
      platforms = platforms.all;
    };
  };
  "textarea-cache" = buildFirefoxXpiAddon {
    pname = "textarea-cache";
    version = "4.10.2";
    addonId = "textarea-cache-lite@wildsky.cc";
    url = "https://addons.mozilla.org/firefox/downloads/file/4355082/textarea_cache-4.10.2.xpi";
    sha256 = "e98270a6f0de4691fe30ef58df02cd8bcf685a4bcdd9b5f37f23268336f26247";
    meta = with lib; {
      description = "Allows to save automatically the content in a text input field.";
      license = licenses.mit;
      mozPermissions = [
        "storage"
        "clipboardWrite"
        "menus"
        "alarms"
        "<all_urls>"
      ];
      platforms = platforms.all;
    };
  };
  "tranquility-reader" = buildFirefoxXpiAddon {
    pname = "tranquility-reader";
    version = "3.0.26";
    addonId = "tranquility@ushnisha.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/4300302/tranquility_1-3.0.26.xpi";
    sha256 = "0effa816ae196eca8f2403c62738b182e6e7ce26477bafda8f27d3f958996330";
    meta = with lib; {
      homepage = "https://github.com/ushnisha/tranquility-reader-webextensions";
      description = "Tranquility Reader improves the readability of web articles by removing unnecessary elements like ads, images, social sharing widgets, and other distracting fluff.";
      license = licenses.gpl3;
      mozPermissions = [
        "<all_urls>"
        "activeTab"
        "storage"
        "alarms"
        "contextMenus"
      ];
      platforms = platforms.all;
    };
  };
  "userchrome-toggle-extended" = buildFirefoxXpiAddon {
    pname = "userchrome-toggle-extended";
    version = "2.0.1";
    addonId = "userchrome-toggle-extended@n2ezr.ru";
    url = "https://addons.mozilla.org/firefox/downloads/file/4341014/userchrome_toggle_extended-2.0.1.xpi";
    sha256 = "3f5be2684284c0b79aaad0f70872a87f21a9a1329a5eaf8e60090e6f0e6a741d";
    meta = with lib; {
      description = "This extension allows you to toggle userchrome.css styles on-the-fly with buttons and hotkeys. You'll be able to switch up to six styles";
      license = licenses.mpl20;
      mozPermissions = [ "storage" ];
      platforms = platforms.all;
    };
  };
}
