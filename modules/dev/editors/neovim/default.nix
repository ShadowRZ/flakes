{ inputs, ... }:
{
  flake.modules = {
    nixos = {
      dev = _: {
        programs.neovim = {
          enable = true;
          defaultEditor = true;
        };
      };
    };
    nixOnDroid = {
      shell = _: {
        environment.sessionVariables."EDITOR" = "nvim";
      };
    };
    homeManager = {
      dev =
        { ... }:
        {
          imports = [
            inputs.nixvim.homeModules.nixvim
          ];

          programs.nixvim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
            viAlias = true;
            vimdiffAlias = true;

            nixpkgs.useGlobalPackages = true;

            colorscheme = "catppuccin-mocha";
            opts = {
              title = true;
              number = true;
              mouse = "a";
              background = "dark";
              termguicolors = true;

              tabstop = 8;
              shiftwidth = 4;
              softtabstop = 4;
              expandtab = true;
            };
            globals = {
              neovide_padding_top = 5;
              neovide_padding_bottom = 5;
              neovide_padding_right = 4;
              neovide_padding_left = 4;
            };

            editorconfig = {
              enable = true;
            };

            colorschemes = {
              catppuccin = {
                enable = true;
              };
            };

            plugins = {
              lsp = {
                enable = true;
              };
              treesitter = {
                enable = true;
                highlight.enable = true;
                indent.enable = true;
                folding.enable = true;
              };
              lualine = {
                enable = true;
              };
              blink-cmp = {
                enable = true;
              };
            };

            lsp = {

              servers = {
                "*" = {
                  config = {
                    capabilities = {
                      textDocument = {
                        semanticTokens = {
                          multilineTokenSupport = true;
                        };
                      };
                    };
                    root_markers = [
                      ".git"
                    ];
                  };
                };
                clangd = {
                  config = {
                    cmd = [
                      "clangd"
                      "--background-index"
                    ];
                    filetypes = [
                      "c"
                      "cpp"
                    ];
                    root_markers = [
                      "compile_commands.json"
                      "compile_flags.txt"
                    ];
                  };
                  enable = true;
                };
                lua_ls = {
                  enable = true;
                };
                rust_analyzer = {
                  enable = true;
                };
                nixd = {
                  enable = true;
                };
              };
            };
          };
        };
    };
  };
}
