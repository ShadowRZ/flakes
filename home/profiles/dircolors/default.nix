{
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile ./dircolors.dircolors;
  };
}
