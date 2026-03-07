{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
        shellInit = ''
          function fish_title
            if set -q argv[1]
              echo $USER@$hostname: $argv;
            else
              echo $USER@$hostname: (fish_prompt_pwd_dir_length=0 prompt_pwd);
            end
          end

          function fish_greeting
            if test -n "$ZELLIJ" || test -n "$TERMUX_VERSION"
              echo (set_color brcyan -o)Fish $version
              echo (set_color brmagenta -o)"@ Hanekokoro Flake (https://github.com/ShadowRZ/hanekokoro-flake)"
            else
              fastfetch
            end
          end
        '';
        binds = {
          "ctrl-z".command = "fg";
        };
        plugins = [
          {
            name = "plugin-git";
            inherit (pkgs.fishPlugins.plugin-git) src;
          }
        ];
      };
    };
}
