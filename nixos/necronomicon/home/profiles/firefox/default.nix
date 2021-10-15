{ lib, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = { enablePlasmaBrowserIntegration = true; };
    };
  };
}
