final: prev: {
  # lilydjwg/subreap
  zsh = prev.zsh.overrideAttrs
    (attrs: { patches = attrs.patches ++ [ ./patches/zsh-subreap.patch ]; });
  shadowrz.subreaper = import ./subreaper final;
  shadowrz.wl-session = final.writeScript "wl-session" ''
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
}
