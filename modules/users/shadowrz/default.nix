{ config, ... }:
{
  flake = {
    meta = {
      users = {
        shadowrz = {
          name = "Yorusaka Miyabi";
          username = "shadowrz";
          key = "AC597AD389D1CC5618AD1ED9B7123A2B6B0AE434";
          git = {
            name = "夜坂雅";
            email = "23130178+ShadowRZ@users.noreply.github.com";
          };
          authorizedKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2Y7fSAJgH4KJZYsKJo01SVCCoV0A4wmD0etDM394PO"
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIEefVfXDrB8oeQUBLmdkbANL0+z6jJVkb1S9rdjhRsJLAAAABHNzaDo="
          ];
        };
      };
    };

    modules.nixos = {
      shadowrz =
        { pkgs, ... }:
        {
          imports = [
            (
              { config, ... }:
              {
                users.users.shadowrz.hashedPasswordFile = config.sops.secrets.passwd.path;
              }
            )
          ];

          users.users.shadowrz = {
            uid = 1000;
            isNormalUser = true;
            shell = pkgs.zsh;
            description = config.flake.meta.users.shadowrz.name;

            extraGroups = [
              "wheel"
              "networkmanager"
              "wireshark"
            ];

            packages = with pkgs; [
              hugo # Hugo
              ffmpeg-full # FFmpeg
              cntr
            ];

            openssh.authorizedKeys.keys = config.flake.meta.users.shadowrz.authorizedKeys;
          };
        };
    };
  };
}
