final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs (attrs: {
    patches = (attrs.patches or [ ]) ++ [ ./patches/zsh-subreap.patch ];
  });
  shadowrz = {
    firefox-addons = final.callPackage ../firefox/addons.nix {
      inherit (final.firefox-addons) buildFirefoxXpiAddon;
    };
  };
}
