{
  flake.modules.nix-on-droid = {
    shell =
      { lib, pkgs, ... }:
      {
        environment.sessionVariables."PAGER" = lib.getExe pkgs.less;
      };
  };
}
