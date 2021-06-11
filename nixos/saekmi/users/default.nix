{ pkgs, ... }: {
  home-manager.users = { futaba = import ./futaba/home.nix; };

  users.users = {
    futaba = {
      uid = 1000;
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "佐仓双叶";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}
