{
  flake.modules =
    let
      stateVersion = "25.05";
    in
    {
      nixos = {
        base = _: {
          # DO NOT FIDDLE WITH THIS VALUE !!!
          # This value determines the NixOS release from which the default
          # settings for stateful data, like file locations and database versions
          # on your system were taken.
          # Before changing this value (which you shouldn't do unless you have
          # REALLY NECESSARY reason to do this) read the documentation for this option
          # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
          # and release notes, SERIOUSLY.
          system.stateVersion = stateVersion; # Did you read the comment?
        };
      };

      homeManager = {
        base = _: {
          # This value determines the Home Manager release that your
          # configuration is compatible with. This helps avoid breakage
          # when a new Home Manager release introduces backwards
          # incompatible changes.
          #
          # You can update Home Manager without changing this value. See
          # the Home Manager release notes for a list of state version
          # changes in each release.
          home.stateVersion = stateVersion;
        };
      };

      nixOnDroid = {
        base = {
          system.stateVersion = "23.05";
        };
      };
    };
}
