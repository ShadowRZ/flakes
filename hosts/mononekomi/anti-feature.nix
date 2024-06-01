{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config = {
    # Solely allows some packages
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) ["vscode" "code"]
      || pkgs.lib.any
      (prefix: pkgs.lib.hasPrefix prefix (pkgs.lib.getName pkg)) [
        "steam"
        "nvidia"
      ];
    # Solely allows Electron
    allowInsecurePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) ["electron"];
  };
}
