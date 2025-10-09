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

        # https://github.com/rose-pine/termux/blob/master/app/src/main/assets/colors/ros%C3%A9-pine-dawn.properties
        terminal.colors = {
          background = "#faf4ed";
          foreground = "#575279";
          cursor = "#797593";
          color0 = "#f2e9e1";
          color8 = "#797593";
          color1 = "#b4637a";
          color9 = "#b4637a";
          color2 = "#286983";
          color10 = "#286983";
          color3 = "#ea9d34";
          color11 = "#ea9d34";
          color4 = "#56949f";
          color12 = "#56949f";
          color5 = "#907aa9";
          color13 = "#907aa9";
          color6 = "#d7827e";
          color14 = "#d7827e";
          color7 = "#575279";
          color15 = "#575279";
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
            inputs.nix-indexdb.homeModules.nix-index
            {
              programs.nix-index-database.comma.enable = true;
            }
          ];
        };
      };
  };
}
