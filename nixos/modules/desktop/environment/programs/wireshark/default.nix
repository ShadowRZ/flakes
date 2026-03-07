{
  flake.modules.nixos = {
    desktop =
      { pkgs, ... }:
      {
        programs.wireshark = {
          enable = true;
        };

        users.users.shadowrz = {
          packages = [ pkgs.wireshark ];
        };
      };
  };
}
