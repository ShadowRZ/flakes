final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs (attrs: {
    patches = (attrs.patches or [ ]) ++ [ ./patches/zsh-subreap.patch ];
  });
  mpv-unwrapped = prev.mpv-unwrapped.overrideAttrs (attrs: {
    patches = (attrs.patches or [ ]) ++ [
      (prev.fetchpatch {
        url =
          "https://github.com/mpv-player/mpv/commit/431473310f9d86f6ae030ce3432897edebe5ab89.patch";
        sha256 = "sha256-DEeg0ntSV5+VXDdi6xiyW/h+//mPQwa6dahLRZjdIOo=";
      })
    ];
  });
}
