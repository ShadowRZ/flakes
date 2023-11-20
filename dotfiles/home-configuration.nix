# Shared configuration.

{ pkgs, lib, ... }: {

  home = { stateVersion = "23.05"; };

  programs = {
    # Zsh
    zsh = {
      enable = true;
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
      initExtra = builtins.readFile ./files/zshrc;
    };
    ### Dircolors
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile ./files/dracula.dircolors;
    };
  };
}
