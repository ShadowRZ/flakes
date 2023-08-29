{ pkgs, ... }:
let
  sddm-theme-conf = pkgs.runCommandLocal "themes.conf-override" { } ''
    mkdir -p $out/share/sddm/themes/breeze/
    cat > $out/share/sddm/themes/breeze/theme.conf.user << CONF
    [General]
    background=${pkgs.nixos-artwork.wallpapers.nineish}/share/backgrounds/nixos/nix-wallpaper-nineish.png
    CONF
  '';
in { environment.systemPackages = [ sddm-theme-conf ]; }
