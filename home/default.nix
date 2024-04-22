# Shared configuration.

{ config, pkgs, lib, ... }: {

  home = {
    stateVersion = "24.05";
    shellAliases = {
      df = "df -h";
      du = "du -h";
      grep = "grep --color=auto";
      ls = "ls -h --group-directories-first --color=auto";

      chmod = "chmod --preserve-root -v";
      chown = "chown --preserve-root -v";

      ll = "ls -l";
      l = "ll -A";
      la = "ls -a";
    };
  };

  programs = {
    less = { enable = true; };
    lesspipe = { enable = true; };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
        hide_running_in_container = false;
        shadow_other_users = true;
        show_thread_names = true;
        show_program_path = true;
        highlight_base_name = true;
        highlight_deleted_exe = true;
        shadow_distribution_path_prefix = true;
        highlight_megabytes = true;
        highlight_threads = true;
        highlight_changes = true;
        highlight_changes_delay_secs = 5;
        find_comm_in_cmdline = true;
        strip_exe_from_cmdline = true;
        enable_mouse = true;
        tree_view = true;
      };
    };
    # Zsh
    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      autocd = true;
      history = { ignoreAllDups = true; };
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = { enable = true; };
      history = {
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        size = 50000;
        save = 50000;
        share = false;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
      shellGlobalAliases = {
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";
        "......." = "../../../../../..";
      };
      historySubstringSearch = {
        enable = true;
        searchUpKey = [ "$key[Up]" ];
        searchDownKey = [ "$key[Down]" ];
      };
      initExtraFirst = lib.mkBefore ''
        # Subreap
        { zmodload lilydjwg/subreap && subreap; } >/dev/null 2>&1
        # Enable terminal cursor
        ${pkgs.util-linux}/bin/setterm -cursor on
        ${pkgs.coreutils}/bin/stty -ixon # Disable flow control

        setopt HIST_VERIFY
        setopt HIST_FIND_NO_DUPS
        setopt HIST_SAVE_NO_DUPS
        setopt HIST_REDUCE_BLANKS
        setopt EXTENDED_HISTORY
        setopt INC_APPEND_HISTORY_TIME
        setopt ALWAYS_TO_END
        setopt LIST_PACKED
        setopt COMPLETE_IN_WORD
        setopt MENU_COMPLETE
        setopt PUSHD_IGNORE_DUPS
        setopt PUSHD_SILENT
        setopt PUSHD_TO_HOME
        setopt AUTO_PUSHD
        setopt EXTENDED_GLOB
        setopt MAGIC_EQUAL_SUBST
        setopt NO_CLOBBER
        setopt INTERACTIVE_COMMENTS
        setopt RC_QUOTES
        setopt CORRECT
        setopt NO_FLOW_CONTROL
        setopt TRANSIENT_RPROMPT
        setopt NO_BEEP
      '';
      initExtra = with pkgs; ''
        . ${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        . ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

        ${builtins.readFile ./files/zinputrc.zsh}
        ${builtins.readFile ./files/zshrc}
      '';
    };
    ### Dircolors
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile ./files/dircolors.dircolors;
    };
    ### Starship
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./files/starship.toml);
    };
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
  };

  systemd.user = {
    # Session variables for Systemd user units.
    # Plasma (+systemd) & GDM launched session reads these too.
    sessionVariables = {
      LESSHISTFILE = "-";
      GST_VAAPI_ALL_DRIVERS = "1";
      # Fcitx 5
      XMODIFIERS = "@im=fcitx";
      # Inherits from home.sessionVariables
      GNUPGHOME = config.home.sessionVariables.GNUPGHOME;
      GTK_CSD = config.home.sessionVariables.GTK_CSD;
    };
  };

  services = {
    ### GnuPG Agent
    gpg-agent = {
      enable = true;
      extraConfig = ''
        allow-loopback-pinentry
        allow-emacs-pinentry
      '';
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
