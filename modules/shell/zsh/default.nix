{
  flake.modules = {
    nixos = {
      shell = {
        programs = {
          zsh = {
            enable = true;
            enableLsColors = false;
          };
        };
      };
    };
    nix-on-droid = {
      shell =
        { lib, pkgs, ... }:
        {
          user.shell = lib.getExe pkgs.zsh;
          environment.sessionVariables."SHELL" = lib.getExe pkgs.zsh;
        };
    };
    homeManager = {
      shell =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          programs.zsh = {
            enable = true;
            defaultKeymap = "emacs";
            autocd = true;
            history = {
              ignoreAllDups = true;
            };
            autosuggestion.enable = true;
            enableCompletion = true;
            syntaxHighlighting = {
              enable = true;
            };
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
            initContent = lib.mkMerge [
              (lib.mkBefore ''
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
              '')
              (with pkgs; ''
                . ${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
                . ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

                ${builtins.readFile ./zinputrc.zsh}
                ${builtins.readFile ./zshrc}
              '')
            ];
          };
        };
    };
  };
}
