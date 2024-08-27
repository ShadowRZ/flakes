{ pkgs, ... }:
{
  users.users.shadowrz = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "夜坂雅";
  };

  home-manager.users.shadowrz = {
    imports = [ ../../home ];

    home = {
      username = "shadowrz";
      homeDirectory = "/home/shadowrz";
    };
  };
}
