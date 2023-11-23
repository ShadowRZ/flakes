{
  programs = {
    less = { enable = true; };
    lesspipe = { enable = true; };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };
    zsh = {
      autocd = true;
      history = { ignoreAllDups = true; };
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = { enable = true; };
      initExtraFirst = ''
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
      initExtra = builtins.readFile ./files/zshrc;
    };
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./files/starship.toml);
    };
  };
}
