{
  buildFirefoxXpiAddon,
  lib,
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
    version = "3.25";
    addonId = "emoji@saveriomorelli.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/4541694/emoji_sav-3.25.xpi";
    sha256 = "0448a650c146b40e66191fd5ab68ef37bca1125c91a6665eded68350b4f97205";
    meta = with lib; {
      homepage = "https://www.emojiaddon.com";
      description = "It permits just with a single click to copy an emoji.\nThere is a search-box and the \"Most used emojis\" section (the first one).\n\nIf you want to send feedback or report bug, please contact me";
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
    version = "2.15.0";
    addonId = "firefoxpwa@filips.si";
    url = "https://addons.mozilla.org/firefox/downloads/file/4537285/pwas_for_firefox-2.15.0.xpi";
    sha256 = "75dda1bfd5b4737210c7bec1949de939e1c8f3f5d0ac4f196c0d8fd24d9657ce";
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
    version = "5.0.4";
    addonId = "textarea-cache-lite@wildsky.cc";
    url = "https://addons.mozilla.org/firefox/downloads/file/4477429/textarea_cache-5.0.4.xpi";
    sha256 = "924ec496f64581bd6d0bdf5c4c344213704125e5cd84216fd2227bee17aa00ba";
    meta = with lib; {
      description = "Allows to save automatically the content in a text input field.";
      license = licenses.mit;
      mozPermissions = [
        "storage"
        "clipboardWrite"
        "menus"
        "tabs"
        "activeTab"
        "<all_urls>"
      ];
      platforms = platforms.all;
    };
  };
}
