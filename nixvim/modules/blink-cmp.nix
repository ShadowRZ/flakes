{
  flake.modules.nixvim.default = _: {
    plugins = {
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "enter";
          };

          cmdline = {
            keymap.preset = "inherit";
            completion.menu.auto_show = false;
          };

          completion = {
            accept = {
              auto_brackets = {
                enabled = true;
                semantic_token_resolution = {
                  enabled = true;
                };
              };
            };
            list.selection = {
              preselect = false;
            };
            documentation = {
              auto_show = true;
            };
          };

          signature = {
            enabled = true;
          };

          sources = {
            cmdline = [ ];
            providers = {
              buffer = {
                score_offset = -7;
              };
              lsp = {
                fallbacks = [ ];
              };
            };
          };
        };
      };
    };
  };
}
