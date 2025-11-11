{
  flake.modules.homeManager = {
    shell =
      { pkgs, ... }:
      {
        programs.zellij = {
          enable = true;
          enableFishIntegration = true;
          layouts = {
            default = ./layouts/default.kdl;
            strider = ./layouts/strider.kdl;
          };
          settings = {
            theme = "catppuccin-mocha";
            simplified_ui = true;
            pane_frames = false;
            on_force_close = "detach";
            session_name = "Amphoreus";
            attach_to_session = true;
            show_startup_tips = false;
            show_release_notes = true;
            advanced_mouse_actions = true;
            copy_on_select = false;
            plugins = {
              # Preserve all builtin plugins
              tab-bar = {
                location = "zellij:tab-bar";
              };
              status-bar = {
                location = "zellij:status-bar";
              };
              strider = {
                location = "zellij:strider";
              };
              compact-bar = {
                location = "zellij:compact-bar";
              };
              session-manager = {
                location = "zellij:session-manager";
              };
              configuration = {
                location = "zellij:configuration";
              };
              plugin-manager = {
                location = "zellij:plugin-manager";
              };
              about = {
                location = "zellij:about";
              };
              welcome-screen = {
                location = "zellij:session-manager";
                welcome_screen = true;
              };
              filepicker = {
                location = "zellij:strider";
                cwd = "/";
              };

              # User Plugins
              zjstatus = {
                location = "file:~/.config/zellij/plugins/zjstatus.wasm";
              };
              zj-forgot = {
                location = "file:~/.config/zellij/plugins/zj-forgot.wasm";
              };
            };
          };
          extraConfig = builtins.readFile ./config.kdl;
        };

        xdg.configFile = {
          "zellij/plugins/zjstatus.wasm".source = pkgs.fetchurl {
            url = "https://github.com/dj95/zjstatus/releases/download/v0.21.1/zjstatus.wasm";
            hash = "sha256-3BmCogjCf2aHHmmBFFj7savbFeKGYv3bE2tXXWVkrho=";
          };
          "zellij/plugins/zj-forgot.wasm".source = pkgs.fetchurl {
            url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.2/zellij_forgot.wasm";
            hash = "sha256-MRlBRVGdvcEoaFtFb5cDdDePoZ/J2nQvvkoyG6zkSds=";
          };
        };
      };
  };
}
