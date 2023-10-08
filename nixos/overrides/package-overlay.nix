final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs (attrs: {
    patches = (attrs.patches or [ ]) ++ [ ./patches/zsh-subreap.patch ];
  });
}
