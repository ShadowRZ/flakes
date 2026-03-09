{
  flake.modules.nixvim.default = _: {
    colorschemes = {
      catppuccin = {
        enable = true;
      };
    };

    colorscheme = "catppuccin-mocha";
  };
}
