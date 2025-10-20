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
          wget
          tree
          man-pages
          curl
          ncurses
        ];

        # Backup etc files instead of failing to activate generation if a file already exists in /etc
        environment.etcBackupExtension = ".bak";

        terminal.font = "${pkgs.hanekokoro-mono}/share/fonts/truetype/HanekokoroMono-Regular.ttf";

        # https://github.com/catppuccin/termux/blob/main/themes/catppuccin-mocha.properties
        terminal.colors = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          color0 = "#45475a";
          color8 = "#585b70";
          color1 = "#f38ba8";
          color9 = "#f38ba8";
          color2 = "#a6e3a1";
          color10 = "#a6e3a1";
          color3 = "#f9e2af";
          color11 = "#f9e2af";
          color4 = "#89b4fa";
          color12 = "#89b4fa";
          color5 = "#f5c2e7";
          color13 = "#f5c2e7";
          color6 = "#94e2d5";
          color14 = "#94e2d5";
          color7 = "#bac2de";
          color15 = "#a6adc8";
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
