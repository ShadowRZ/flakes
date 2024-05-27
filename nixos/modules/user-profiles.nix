{ pkgs, ... }: {

  # Users
  users = {
    mutableUsers = false;
    users = {
      shadowrz = {
        uid = 1000;
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "夜坂雅";
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
          ".java"
          ".local"
          ".logseq"
          ".mozilla"
          ".renpy"
          ".thunderbird"
          ".var"
          ".vscode"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
        ];
      };
      root = {
        home = "/root";
        directories = [ ".cache/nix" ];
      };
    };
  };
}
