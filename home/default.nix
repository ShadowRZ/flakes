# Shared configuration.
{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    username = lib.mkDefault "shadowrz";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

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

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  imports = [
    ./programs/dircolors
    ./programs/direnv
    ./programs/git
    ./programs/gnupg
    ./programs/neovim
    ./programs/nix
    ./programs/htop
    ./programs/starship
    ./programs/zsh
  ];

  programs.aria2.enable = true;
  programs.ripgrep.enable = true;
  programs.zoxide.enable = true;

  home.packages = with pkgs; [fd];
}
