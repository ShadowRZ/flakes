{
  flake.modules.homeManager = {
    desktop = {
      xdg.configFile = {
        "fontconfig/conf.d/99-fontconfig.conf".source = ./fontconfig.conf;
      };
    };
  };
}
