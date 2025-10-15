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

        # https://github.com/catppuccin/termux/blob/main/themes/catppuccin-latte.properties
        terminal.colors = {
          background = "#eff1f5";
          foreground = "#4c4f69";
          color0 = "#5c5f77";
          color8 = "#acb0be";
          color1 = "#d20f39";
          color9 = "#d20f39";
          color2 = "#40a02b";
          color10 = "#40a02b";
          color3 = "#df8e1d";
          color11 = "#df8e1d";
          color4 = "#1e66f5";
          color12 = "#1e66f5";
          color5 = "#ea76cb";
          color13 = "#ea76cb";
          color6 = "#179299";
          color14 = "#179299";
          color7 = "#acb0be";
          color15 = "#bcc0cc";
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
