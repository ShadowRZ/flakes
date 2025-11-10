{ withSystem, ... }:
{
  flake.modules.homeManager = {
    shell =
      { pkgs, ... }:
      {
        programs.zellij = {
          enable = true;
          enableFishIntegration = true;
          layouts =
            let
              zjstatus = withSystem pkgs.stdenv.hostPlatform.system (
                { inputs', ... }: inputs'.zjstatus.packages.default
              );
              default_tab_template = {
                _children = [
                  { "children" = { }; }
                  {
                    pane = {
                      size = 2;
                      borderless = true;
                      _children = [
                        {
                          plugin = {
                            _props = {
                              location = "file:${zjstatus}/bin/zjstatus.wasm";
                            };

                            format_left = "{mode}  {tabs}";
                            format_right = "{datetime} · #[fg=#94E2D5,bold]~> {session}";
                            format_space = "";

                            datetime = "#[fg=#7F849C,bold]{format}";
                            datetime_format = "%Y-%m-%d %H:%M:%S";
                            datetime_timezone = "Asia/Shanghai";

                            border_enabled = "true";
                            border_char = "·";
                            border_format = "#[fg=#45475A]";
                            border_position = "top";

                            mode_normal = "#[fg=#A6E3A1,bold]-- NORMAL";
                            mode_locked = "#[fg=#F38BA8,bold]## LOCKED";
                            mode_resize = "#[fg=#F5C2E7,bold]<> RESIZE";
                            mode_pane = "#[fg=#F2CDCD,bold][] PANE";
                            mode_move = "#[fg=#FAB387,bold]>> MOVE";
                            mode_tab = "#[fg=#94E2D5,bold]~~ TAB";
                            mode_scroll = "#[fg=#F5E0DC,bold]|| SCROLL";
                            mode_search = "#[fg=#F9E2AF,bold]// SEARCH";
                            mode_enter_search = "#[fg=#F9E2AF,bold]// ENTER SEARCH";
                            mode_rename_tab = "#[fg=#EBA0AC,bold]++ RENAME TAB";
                            mode_rename_pane = "#[fg=#EBA0AC,bold]++ RENAME PANE";
                            mode_session = "#[fg=#B4BEFE,bold]·· SESSION";
                            mode_tmux = "#[fg=#94E2D5,bold]-> TMUX";
                            mode_default_to_mode = "tmux";

                            tab_normal = "#[fg=#585B70][#{index}] {name}  ";
                            tab_normal_fullscreen = "#[fg=#585B70][#{index}] {name} []  ";
                            tab_normal_sync = "#[fg=#585B70][#{index}] {name} <>  ";
                            tab_active = "#[fg=#F2CDCD,bold][#{index}] {name} {floating_indicator} ";
                            tab_active_fullscreen = "#[fg=#F2CDCD,bold][#{index}] {name} {fullscreen_indicator} ";
                            tab_active_sync = "#[fg=#F2CDCD,bold][#{index}] {name} {sync_indicator} ";
                            tab_rename = "#[fg=#FAB387,bold][#{index}] > {name} <";

                            tab_sync_indicator = "<> ";
                            tab_fullscreen_indicator = "[] ";
                            tab_floating_indicator = "^^ ";

                            tab_display_count = "9";
                            tab_truncate_start_format = "#[fg=#F2CDCD]<< {count}+ ·· ";
                            tab_truncate_end_format = "#[fg=#F2CDCD] ·· {count}+ >>";
                          };
                        }
                      ];
                    };
                  }
                ];
              };
            in
            {
              default = {
                layout = {
                  _children = [
                    {
                      inherit default_tab_template;
                    }
                    {
                      tab = {
                        _props = {
                          name = "Htop";
                        };
                        _children = [
                          {
                            pane = {
                              command = "htop";
                              close_on_exit = true;
                            };
                          }
                        ];
                      };
                    }
                    {
                      tab = {
                        _props = {
                          focus = true;
                        };
                        _children = [
                          {
                            pane = { };
                          }
                        ];
                      };
                    }
                  ];
                };
              };
              strider = {
                layout = {
                  _children = [
                    {
                      inherit default_tab_template;
                    }
                    {
                      tab = {
                        _props = {
                          name = "Htop";
                        };
                        _children = [
                          {
                            pane = {
                              split_direction = "Vertical";
                              _children = [
                                {
                                  pane = {
                                    size = "20%";
                                    _children = [
                                      {
                                        plugin = {
                                          location = "strider";
                                        };
                                      }
                                    ];
                                  };
                                }
                                { pane = { }; }
                              ];
                            };
                          }
                        ];
                      };
                    }
                  ];
                };
              };
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
          };
        };
      };
  };
}
