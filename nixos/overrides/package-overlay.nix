final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs (attrs: {
    patches = (attrs.patches or [ ]) ++ [ ./patches/zsh-subreap.patch ];
  });
  libsForQt5 = prev.libsForQt5.overrideScope' (qfinal: qprev: {
    sddm = qprev.sddm.overrideAttrs (old: {
      version = "unstable-2023-09-19";
      src = old.src.override {
        rev = "8c370d97c14836864e9a038975f7f4cca1418554";
        hash = "sha256-SLpU32fpDfnyFUsNYLJYytu6Lu2bDAD6QLEHjbugOQA=";
      };
    });
  });
}
