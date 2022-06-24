final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs
    (attrs: { patches = attrs.patches ++ [ ./patches/zsh-subreap.patch ]; });
  shadowrz.subreaper = import ./subreaper final;
  shadowrz.wl-session = prev.writeScript "wl-session" ''
    #!${final.runtimeShell}

    # systemctl(1) path
    systemctl_path=${final.systemd}/bin/systemctl

    # If our environment hasn't setup (/etc/profile is not sourced),
    # and we're on Wayland
    if [[ "$XDG_SESSION_TYPE" = "wayland" ]] && 
       [[ -n $SHELL ]] && [[ -n __ETC_PROFILE_DONE ]]; then
        # Ensure systemd user services get NIX_PROFILES (for GTK+)
        ${final.runtimeShell} -l -c "[[ -n $NIX_PROFILES ]] && $systemctl_path --user import-environment NIX_PROFILES"
        exec -l "$SHELL" "$@"
    fi
  '';
  # [PATCH] Make sure we set client_window/widget to null if app set it.
  # github:fcitx/fcitx5-gtk/20f32a9be56e4c23a9de4bfbbc823ff05746699e
  fcitx5-gtk = prev.fcitx5-gtk.overrideAttrs (attrs: {
    patches = (with prev;
      [
        (fetchpatch {
          url =
            "https://github.com/fcitx/fcitx5-gtk/commit/20f32a9be56e4c23a9de4bfbbc823ff057466993.patch";
          sha256 = "sha256-vf+/FgEnftWtP0KeiJWk3MRLPpHK03ElKosEae0oXzc=";
        })
      ]);
  });
}
