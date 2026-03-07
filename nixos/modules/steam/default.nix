{
  flake.modules.nixos = {
    steam =
      { config, pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          package = pkgs.steam.override {
            extraArgs = "-forcedesktopscaling 1.5";
          };
          protontricks.enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
        };

        environment.systemPackages = [ config.programs.steam.package.run ];
      };
  };
}
