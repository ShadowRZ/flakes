{
  flake.modules = {
    homeManager = {
      desktop = _: {
        fonts.fontconfig.enable = false;
      };
    };
    nixos = {
      desktop =
        { lib, pkgs, ... }:
        {
          # Fonts.
          fonts = {
            enableDefaultPackages = false;
            packages = with pkgs; [
              noto-fonts # Base Noto Fonts
              noto-fonts-color-emoji # Noto Color Emoji
              sarasa-gothic # Sarasa Gothic
              source-han-sans-vf-otf # Source Han Sans Variable
              source-han-serif-vf-otf # Source Han Serif Variable
              dejavu_fonts # DejaVu
              cantarell-fonts # Cantarell
              (google-fonts.override {
                fonts = [
                  "Space Grotesk"
                  "Outfit"
                ];
              })
              nerd-fonts.symbols-only
              (iosevka-bin.override {
                variant = "Aile";
              })
              # Iosevka Builds
              hanekokoro-sans
              hanekokoro-mono
              hanekokoro-mono-e
            ];
            fontconfig = {
              defaultFonts = lib.mkForce {
                # XXX: Qt solely uses the first 255 fonts from fontconfig:
                # https://bugreports.qt.io/browse/QTBUG-80434
                # So put emoji font here.
                sansSerif = [
                  "DejaVu Sans"
                  "Source Han Sans SC VF"
                  "Noto Color Emoji"
                ];
                serif = [
                  "DejaVu Serif"
                  "Source Han Serif SC VF"
                  "Noto Color Emoji"
                ];
                monospace = [
                  "Hanekokoro Mono-E"
                  "Sarasa Mono SC"
                ];
                emoji = [ "Noto Color Emoji" ];
              };
              subpixel.rgba = "rgb";
              localConf = builtins.readFile ./fontconfig.conf;
              cache32Bit = true;
            };
          };
        };
    };
  };
}
