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
      shell = _: {
        programs.fish = {
          enable = true;
          generateCompletions = true;
        };
      };
    };
  };
}
