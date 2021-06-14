{ pkgs, ... }: {
  console = {
    font = "ter-v24b";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
    earlySetup = true;
    colors = [
      "1d2021" # 00
      "fb4934" # 01
      "b8bb26" # 02
      "fabd2f" # 03
      "83a598" # 04
      "d3869b" # 05
      "8ec07c" # 06
      "d5c4a1" # 07
      "665c54" # 08
      "fe8019" # 09
      "3c3836" # 10
      "504945" # 11
      "bdae93" # 12
      "ebdbb2" # 13
      "d65d0e" # 14
      "fbf1c7" # 15
    ];
  };
}
