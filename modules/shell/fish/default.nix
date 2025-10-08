{
  flake.modules = {
    nixos = {
      shell = _: {
        programs = {
          fish = {
            enable = true;
          };
        };
      };
    };
    nixOnDroid = {
      shell =
        { lib, pkgs, ... }:
        {
          user.shell = lib.getExe pkgs.fish;
          environment.sessionVariables."SHELL" = lib.getExe pkgs.fish;
        };
    };
    homeManager = {
      shell =
        { pkgs, ... }:
        {
          programs.fish = {
            enable = true;
            generateCompletions = true;
            shellInit = builtins.readFile ./config.fish;
            binds = {
              "ctrl-z".command = "fg";
            };
            plugins = [
              {
                name = "plugin-git";
                inherit (pkgs.fishPlugins.plugin-git) src;
              }
            ];
          };
        };
    };
  };
}
