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
        krusader # Krusader
        kdenlive # Kdenlive
        blender # Blender
        zim # Zim
        qtcreator # Qt Creator
        dia # Dia
        easyrpg-player # EasyRPG Player
        graphviz # Graphviz
        hugo # Hugo
        yarn # Yarn
        nwjs # NW.js
        nextcloud-client # Nextcloud Client
        qownnotes # QOwnNotes
        claws-mail # Claws Mail
        retroarch # RetroArch
        electron # Electron
      ];
    };
  };

  nixpkgs.config.retroarch = {
    enableDesmume = true;
    enableMGBA = true;
    enablePPSSPP = true;
  };
}
