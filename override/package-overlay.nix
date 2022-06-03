final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs
    (attrs: { patches = attrs.patches ++ [ ./patches/zsh-subreap.patch ]; });
  shadowrz.subreaper = import ./subreaper final;
}
