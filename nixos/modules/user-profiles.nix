{ pkgs, ... }: {

  # Users
  users = {
    mutableUsers = false;
    users = {
      shadowrz = {
        uid = 1000;
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "紫叶零湄";
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [ krusader ];
      };
    };
  };

  # Persistent files
  environment.persistence."/persist" = {
    directories = [ "/var" "/root" ];
    files = [ "/etc/machine-id" ];
    users = {
      shadowrz = {
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Projects"
          "Maildir"
          "Music"
          "Public"
          "Videos"
          ".android"
          ".cache"
          ".cargo"
          ".config"
          ".gnupg"
          ".java"
          ".local"
          ".logseq"
          ".mozilla"
          ".renpy"
          ".ssh"
          ".thunderbird"
          ".var"
          ".vscode"
        ];
        files = [ ".gtkrc-2.0" ];
      };
      root = {
        home = "/root";
        directories = [ ".cache/nix" ];
      };
    };
  };
}
