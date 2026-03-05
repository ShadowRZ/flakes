{
  flake.modules.homeManager = {
    desktop =
      {
        pkgs,
        ...
      }:
      {
        services.emacs = {
          enable = true;
          client.enable = true;
          socketActivation.enable = true;
          startWithUserSession = true;
        };

        programs.emacs = {
          enable = true;
          package = pkgs.emacs-git-pgtk;
          extraPackages = epkgs: with epkgs; [ treesit-grammars.with-all-grammars ];
        };
      };
  };
}
