{
  flake.modules.nixOnDroid = {
    shell =
      { lib, pkgs, ... }:
      {
        environment.sessionVariables."PAGER" = lib.getExe pkgs.less;
      };
  };
}
