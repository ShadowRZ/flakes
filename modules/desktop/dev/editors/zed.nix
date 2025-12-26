{
  flake.modules.homeManager = {
    dev-desktop =
      { pkgs, ... }:
      {
        programs.zed-editor = {
          enable = true;
          package = pkgs.zed-editor.fhsWithPackages (pkgs: [
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
