{ lib, pkgs, ... }: {
  programs = {
    # Zsh
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
      autocd = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      shellGlobalAliases = {
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";
        "......." = "../../../../../..";
      };
      history = {
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        size = 50000;
      };
      initExtra = let
        zshrc = lib.fileContents ./zshrc;
        sources = with pkgs; [
          ./cdr.zsh
          ./dircolors.zsh
          "${skim}/share/skim/completion.zsh"
          "${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh"
          "${oh-my-zsh}/share/oh-my-zsh/plugins/sudo/sudo.plugin.zsh"
          "${oh-my-zsh}/share/oh-my-zsh/plugins/extract/extract.plugin.zsh"
          "${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh"
          "${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
        ];
        source = map (source: "source ${source}") sources;
        plugins = builtins.concatStringsSep "\n" source;
        promptInit = let
          p10k = ./p10k.zsh;
          p10k-linux = ./p10k-linux.zsh;
        in ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ $TERM != *-256color ]] \
            && source ${p10k-linux} \
            || source ${p10k}
        '';
      in ''
        # Subreap
        {
          zmodload lilydjwg/subreap
          subreap
        } >/dev/null 2>&1
        # Fake tty function
        _saved_tty=$TTY
        tty() { echo _saved_tty; }
        # Powerlevek10k Instant prompt
        if [[ -r "${
          "\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}"
        }.zsh" ]]; then
          source "${
            "\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}"
          }.zsh"
        fi

        ### Plugins -- 8< --
        ${plugins}

        ### Zshrc -- 8< --
        ${zshrc}

        ### Prompt -- 8< --
        ${promptInit}

        # Unload fake tty function
        unfunction tty
        unset _saved_tty
      '';
    };
    # Skim
    skim = let
      fd = "${pkgs.fd}/bin/fd -H";
      alt_c_cmd = pkgs.writeScript "cdr-skim.zsh" ''
        #!${pkgs.zsh}/bin/zsh
        ${lib.fileContents ./cdr-skim.zsh}
      '';
    in {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = fd;
      fileWidgetCommand = fd;
      changeDirWidgetCommand = "${alt_c_cmd}";
    };
  };
}
