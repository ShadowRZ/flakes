{
  fileSystems."/persist".neededForBoot = true;
  # Persistent files
  preservation = {
    enable = true;
    preserveAt."/persist" = {
      directories = [
        "/var/log"
        "/var/lib"
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
          how = "symlink";
          configureParent = true;
        }
      ];
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
            ".eclipse"
            ".gradle"
            ".java"
            ".local/share"
            ".local/state"
            ".m2"
            ".mitmproxy"
            ".mozilla"
            ".thunderbird"
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
          files = [
            ".npmrc"
            ".nvidia-settings-rc"
          ];
        };
        root = {
          home = "/root";
          directories = [ ".cache/nix" ];
        };
      };
    };
  };

  systemd.tmpfiles.settings.preservation = {
    "/home/shadowrz/.local/share".d = {
      user = "shadowrz";
      group = "users";
      mode = "0755";
    };
    "/home/shadowrz/.local/state".d = {
      user = "shadowrz";
      group = "users";
      mode = "0755";
    };
  };

  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persist/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persist"
    ];
  };
}
