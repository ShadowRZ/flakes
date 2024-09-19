{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        zlib
        openssl.dev
        sqlite.dev
        pkg-config
      ]
    );
  };
}
