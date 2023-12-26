# Shared config between NixOS / Nix On Droid

{ pkgs, ... }: {

  home = {
    sessionVariables = {
      GTK_CSD = "0";
      XAPIAN_CJK_NGRAM = "1";
    };
  };

  programs = {
    ### GnuPG
    gpg = {
      enable = true;
      settings = {
        personal-digest-preferences = "SHA512";
        cert-digest-algo = "SHA512";
        default-preference-list =
          "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
        personal-cipher-preferences = "TWOFISH CAMELLIA256 AES 3DES";
        keyid-format = "0xlong";
        with-fingerprint = true;
        trust-model = "tofu";
        utf8-strings = true;
        keyserver = "hkps://keys.openpgp.org";
        verbose = false;
      };
    };
    ### Gh
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        version = "1";
      };
    };
    ### Git
    git = {
      enable = true;
      package = pkgs.gitFull;
      # Basic
      userEmail = "23130178+ShadowRZ@users.noreply.github.com";
      userName = "夜坂雅";
      signing = {
        signByDefault = true;
        key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      };
      # Delta highlighter
      delta = {
        enable = true;
        options = {
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
          };
          features = "decorations";
          whitespace-error-style = "22 reverse";
        };
      };
      extraConfig = {
        init.defaultBranch = "master";
        sendemail.identity = "ShadowRZ";
      };
    };
    ### Neovim
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = builtins.readFile ./files/nvim.lua;
      plugins = with pkgs.vimPlugins; [
        lualine-nvim
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        luasnip
        editorconfig-nvim
        nord-vim
        # Tree Sitter
        (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            tree-sitter-nix
            tree-sitter-lua
            tree-sitter-rust
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-python
          ]))
      ];
    };
    ### Aria2
    aria2 = { enable = true; };
    ### Direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # Fontconfig.
  fonts.fontconfig.enable = true;
  xdg.configFile = {
    "fontconfig/conf.d/99-fontconfig.conf".source = ./files/fontconfig.conf;
  };
}
