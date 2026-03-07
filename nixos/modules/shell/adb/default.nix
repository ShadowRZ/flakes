{
  flake.modules.nixos = {
    shell =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.android-tools ];
      };
  };
}
