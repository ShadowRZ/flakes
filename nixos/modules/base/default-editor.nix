{
  flake.modules.nixos = {
    base =
      { lib, ... }:
      {
        programs = {
          nano.enable = lib.mkDefault false;
          # In github:Guanran928/nixos-sensible Vim is set as default editor without
          # programs.vim.enable = true which isn't expected to work.
          # Workaround this.
          # The downside is that NixOS configurations must override with lib.mkForce
          vim.defaultEditor = false;
        };
      };
  };
}
