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
    if [[ -z "$SHELL" ]]; then
        SHELL=${final.runtimeShell}
    fi
    if [[ "$XDG_SESSION_TYPE" = "wayland" ]] && [[ -n __ETC_PROFILE_DONE ]]; then
        # Ensure systemd user services get NIX_PROFILES (for GTK+)
        ${final.runtimeShell} -l -c "$systemctl_path --user import-environment NIX_PROFILES"
        exec -l "$SHELL" -c "$@"
    fi
  '';
  mpv-unwrapped = prev.mpv-unwrapped.overrideAttrs (attrs: {
    patches = (attrs.patches or []) ++ [
      (prev.fetchpatch {
        url = "https://github.com/mpv-player/mpv/commit/431473310f9d86f6ae030ce3432897edebe5ab89.patch";
        sha256 = "sha256-DEeg0ntSV5+VXDdi6xiyW/h+//mPQwa6dahLRZjdIOo=";
      })
    ];
  });
}
