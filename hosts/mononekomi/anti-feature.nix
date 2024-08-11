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
        "android-studio"
        "android-sdk"
        "libXNVCtrl" # ?
      ];
    # Solely allows Electron
    allowInsecurePredicate = pkg:
      builtins.elem (pkgs.lib.getName pkg) ["electron"];
    # https://developer.android.google.cn/studio/terms
    android_sdk.accept_license = true;
  };
}
