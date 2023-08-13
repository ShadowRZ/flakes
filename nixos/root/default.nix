{ config, pkgs, lib, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "root";
  home.homeDirectory = "/root";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  ###### Program configs start here.
  programs = {
    # Zsh
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
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
      initExtraFirst = lib.mkBefore ''
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
      '';
      initExtra = let
        zshrc = lib.fileContents ./zshrc;
        sources = with pkgs; [
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
      in lib.mkAfter ''
        ### Plugins -- 8< --
        ${plugins}

        ### Zshrc -- 8< --
        ${zshrc}

        ### Prompt -- 8< --
        ${promptInit}
      '';
    };
  };
  ###### End of program configs.
}
