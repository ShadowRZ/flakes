{
  flake.modules.homeManager = {
    dev =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.just
          pkgs.just-lsp
          pkgs.just-formatter
        ];
      };
  };
}
