{ inputs, ... }:
{
  flake.modules.nixOnDroid = {
    base =
      { pkgs, ... }:
      {
        environment.packages = with pkgs; [
          openssh

          diffutils
          findutils
          utillinux
          tzdata
          hostname
          man
          gnugrep
          gnupg
          gnused
          gnutar
          bzip2
          gzip
          xz
          zip
          unzip

          dnsutils
          ripgrep
          file
          gdu
          wget
          tree
          man-pages
          curl
          ncurses
        ];

        # Backup etc files instead of failing to activate generation if a file already exists in /etc
        environment.etcBackupExtension = ".bak";

        terminal.font = "${pkgs.hanekokoro-mono}/share/fonts/truetype/HanekokoroMono-Regular.ttf";

        # https://github.com/termux/termux-styling/blob/master/app/src/main/assets/colors/nord.properties
        terminal.colors = {
          foreground = "#d8dee9";
          background = "#2e3440";
          cursor = "#d8dee9";
          color0 = "#3b4252";
          color1 = "#bf616a";
          color2 = "#a3be8c";
          color3 = "#ebcb8b";
          color4 = "#81a1c1";
          color5 = "#b48ead";
          color6 = "#88c0d0";
          color7 = "#e5e8f0";
          color8 = "#4c566a";
          color9 = "#bf616a";
          color10 = "#a3be8c";
          color11 = "#ebcb8b";
          color12 = "#81a1c1";
          color13 = "#b48ead";
          color14 = "#8fbcbb";
          color15 = "#eceff4";
        };

        android-integration = {
          am.enable = true;
          termux-open.enable = true;
          termux-open-url.enable = true;
          termux-reload-settings.enable = true;
          termux-setup-storage.enable = true;
          termux-wake-lock.enable = true;
          termux-wake-unlock.enable = true;
          xdg-open.enable = true;
        };

        home-manager.config = {
          imports = [
            inputs.nix-indexdb.hmModules.nix-index
            {
              programs.nix-index-database.comma.enable = true;
            }
          ];
        };
      };
  };
}
