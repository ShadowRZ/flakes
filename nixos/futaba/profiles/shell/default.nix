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
          p10k = pkgs.writeText "pk10.zsh" (lib.fileContents ./p10k.zsh);
          p10k-linux =
            pkgs.writeText "pk10-linux.zsh" (lib.fileContents ./p10k-linux.zsh);
        in ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ -z $DISPLAY && -z $WAYLAND_DISPLAY ]] \
            && source ${p10k-linux} \
            || source ${p10k}
        '';
      in ''
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
