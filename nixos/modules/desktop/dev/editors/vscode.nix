{
  flake.modules.homeManager = {
    dev-desktop =
      { pkgs, ... }:
      {
        programs.vscode = {
          enable = true;
          package = pkgs.vscode.fhsWithPackages (pkgs: [
            pkgs.libxkbcommon
            pkgs.udev
            pkgs.libinput
            pkgs.libgbm
            pkgs.fontconfig.lib
            pkgs.freetype
          ]);
        };
      };
  };
}
