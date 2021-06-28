{ pkgs, ... }: {
  home-manager.users = { futaba = import ./futaba/home.nix; };

  users.users = {
    futaba = {
      uid = 1000;
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "佐仓双叶";
      extraGroups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [
        diff-so-fancy # Diff So Fancy
        kdenlive # Kdenlive
        blender # Blender
        gocryptfs # gocryptfs
        zim # Zim
        qtcreator # Qt Creator
        dia # Dia
        easyrpg-player # EasyRPG Player
        graphviz # Graphviz
        hugo # Hugo
        yarn # Yarn
        nwjs # NW.js
      ];
    };
  };
}
