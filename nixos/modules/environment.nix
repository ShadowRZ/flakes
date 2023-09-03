{ config, lib, pkgs, ... }: {
  environment = {
    # System level packages.
    systemPackages = with pkgs; [
      coreutils
      curl
      dnsutils
      fd
      iputils
      jq
      ripgrep
      utillinux
      file
      ncdu
      wget
      tree
      nixfmt
      man-pages
      unzip
      p7zip
      unar
      fastfetch
      inxi
      pciutils
      intel-gpu-tools
    ];
    # Set a NIX_BUILD_SHELL
    variables = let
      nix-build-shell = pkgs.writeScript "nix-build-shell" ''
        #!${pkgs.runtimeShell}
        if [[ $IN_NIX_SHELL == 'pure' ]] || [[ $# -eq 1 ]]; then
          # $BASH -> Expands to the full filename used to invoke this instance of bash.
          exec "$BASH" "$@"
        fi

        # Remember the user shell.
        shell=$SHELL

        # nix-shell run this script as (shell) --rcfile $2
        rcfile="$2"
        source "$rcfile"

        export __USER_SHELL=$shell
        # Run user shell.
        exec -a "$shell" "$shell"
      '';
    in { NIX_BUILD_SHELL = "${nix-build-shell}"; };
  };

  # System programs
  programs = {
    java = {
      enable = true;
      package = pkgs.temurin-bin-8;
    };
    less = { enable = true; };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    xonsh = {
      enable = true;
      config = ''
        ${pkgs.util-linux}/bin/setterm -cursor on
        ${pkgs.coreutils}/bin/stty -ixon

        $TITLE = '{user}@{hostname}: {cwd}'
        $PROMPT = '{INTENSE_RED}{user}{RESET} at {INTENSE_PURPLE}{hostname}{RESET} in {BOLD_GREEN}{cwd}{RESET}\n@ '

        $LESS_TERMCAP_mb = "\033[01;31m"
        $LESS_TERMCAP_md = "\033[01;31m"
        $LESS_TERMCAP_me = "\033[0m"
        $LESS_TERMCAP_so = "\033[01;44;36m"
        $LESS_TERMCAP_se = "\033[0m"
        $LESS_TERMCAP_us = "\033[00;36m"
        $LESS_TERMCAP_ue = "\033[0m"

        $XONSH_SHOW_TRACEBACK = True
        $XONSH_STORE_STDOUT = True
        $XONSH_HISTORY_MATCH_ANYWHERE = True
        $COMPLETIONS_CONFIRM = True
        $XONSH_AUTOPAIR = True

        xontrib load coreutils
      '';
    };
    # Disable command-not-found as it's unavliable in Flakes build
    command-not-found = { enable = lib.mkForce false; };
    dconf = { enable = true; };
    # Nix-Index
    nix-index = { enable = true; };
    # Enable Comma
    nix-index-database.comma.enable = true;
  };
}
