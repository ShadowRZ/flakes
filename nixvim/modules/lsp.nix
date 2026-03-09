{
  flake.modules.nixvim.default = _: {
    plugins = {
      lsp = {
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
}
