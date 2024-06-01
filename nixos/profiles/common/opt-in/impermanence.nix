{
  fileSystems."/persist".neededForBoot = true;
  # Persistent files
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = ["/var/log" "/var/lib"];
    files = ["/etc/machine-id"];
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
          ".config" # FIXME
          ".java"
          ".local"
          ".logseq"
          ".mitmproxy"
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
        directories = [".cache/nix"];
      };
    };
  };
}
