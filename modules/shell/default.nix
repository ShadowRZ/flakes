{
  flake.modules.homeManager = {
    shell = {
      programs.aria2.enable = true;
      programs.ripgrep.enable = true;
      programs.zoxide.enable = true;
      programs.jq.enable = true;
      programs.fd.enable = true;
      programs.yt-dlp.enable = true;
    };
  };
}
