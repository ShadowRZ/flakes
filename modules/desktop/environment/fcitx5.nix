{
  flake.modules.nixos = {
    desktop =
      { pkgs, ... }:
      {
        i18n = {
          # Fcitx 5
          inputMethod = {
            enable = true;
            type = "fcitx5";
            fcitx5 = {
              waylandFrontend = true;
              addons = with pkgs; [
                kdePackages.fcitx5-chinese-addons
                fcitx5-pinyin-moegirl
                fcitx5-pinyin-zhwiki
              ];
            };
          };
        };
      };
  };
}
