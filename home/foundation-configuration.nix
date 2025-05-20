# Shared configuration.
{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  imports = [
    ./modules/dircolors
    ./modules/direnv
    ./modules/git
    ./modules/gnupg
    ./modules/neovim
    ./modules/nix
    ./modules/htop
    ./modules/starship
    ./modules/zsh
  ];

  programs.aria2.enable = true;
  programs.ripgrep.enable = true;
  programs.zoxide.enable = true;
  programs.jq.enable = true;
  programs.fd.enable = true;
  programs.yt-dlp.enable = true;

  services.ssh-agent.enable = true;
}
