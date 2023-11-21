# Shared configuration.

{ config, pkgs, lib, ... }: {

  home = { stateVersion = "23.05"; };

  programs = {
    # Zsh
    zsh = {
      enable = true;
      history = {
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        size = 50000;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
      shellGlobalAliases = {
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";
        "......." = "../../../../../..";
      };
      historySubstringSearch.enable = true;
      initExtraFirst = lib.mkBefore ''
        # Subreap
        { zmodload lilydjwg/subreap && subreap; } >/dev/null 2>&1
        # Enable terminal cursor
        ${pkgs.util-linux}/bin/setterm -cursor on
        ${pkgs.coreutils}/bin/stty -ixon # Disable flow control
      '';
      initExtra = with pkgs; ''
        . ${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh
        . ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

        ${builtins.readFile ./files/zshrc}
      '';
    };
    ### Dircolors
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile ./files/dracula.dircolors;
    };
  };
}