{
  flake.modules.nixos = {
    base =
      _:
      {
        # Increase open files for all users
        systemd.user.extraConfig = ''
          DefaultLimitNOFILE=524288:524288
        '';

        services.journald.extraConfig = ''
          SystemMaxUse=100M
          MaxFileSec=3day
        '';

        services.nscd.enableNsncd = true;
      };
  };
}
