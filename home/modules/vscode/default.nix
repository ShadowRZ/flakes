{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    # CodeLLDB should use the Nixpkgs one for non FHS usage
    extensions = [ pkgs.vscode-extensions.vadimcn.vscode-lldb ];
    mutableExtensionsDir = true;
  };
}
