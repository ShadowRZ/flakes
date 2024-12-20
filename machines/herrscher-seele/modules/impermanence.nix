{
  inputs,
  ...
}:
{
  imports = with inputs; [
    impermanence.nixosModules.impermanence
  ];

  fileSystems."/persist".neededForBoot = true;
  # Persistent files
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib"
    ];
    files = [ "/etc/machine-id" ];
    users = {
      shadowrz = {
        directories = [
          "Desktop"
          "Documents"
          "Downloads"
          "Pictures"
          "Projects"
          "Music"
          "Public"
          "Templates"
          "Videos"
          ".android"
          ".cache"
          ".cargo"
          ".config" # FIXME
          ".gradle"
          ".java"
          ".local"
          ".logseq"
          ".m2"
          ".mitmproxy"
          ".mozilla"
          ".renpy"
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
        files = [ ".npmrc" ];
      };
      root = {
        home = "/root";
        directories = [ ".cache/nix" ];
      };
    };
  };
}
