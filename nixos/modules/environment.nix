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
    # Link /share/zsh
    pathsToLink = [ "/share/zsh" ];
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
    zsh = {
      enable = true;
      autosuggestions = { enable = true; };
      syntaxHighlighting = { enable = true; };
      histSize = 50000;
      setOptions = [
        # History related options.
        "HIST_VERIFY"
        "HIST_FIND_NO_DUPS"
        "HIST_SAVE_NO_DUPS"
        "HIST_REDUCE_BLANKS"
        # Completion related options.
        "ALWAYS_TO_END"
        "AUTO_MENU"
        "LIST_TYPES"
        "LIST_PACKED"
        "COMPLETE_IN_WORD"
        "MENU_COMPLETE"
        # Navigation related options.
        "PUSHD_MINUS"
        "PUSHD_IGNORE_DUPS"
        "PUSHD_SILENT"
        "PUSHD_TO_HOME"
        "AUTO_PUSHD"
        # Globbing related options.
        "BAD_PATTERN"
        "EXTENDED_GLOB"
        "NOMATCH"
        "MAGIC_EQUAL_SUBST"
        # I/O related options.
        "NO_CLOBBER"
        "INTERACTIVE_COMMENTS"
        "RC_QUOTES"
        "CORRECT"
        "NO_FLOW_CONTROL"
        # Jobs.
        "LONG_LIST_JOBS"
        "NO_BG_NICE"
        # Remove any RPROMPT after executing command.
        "TRANSIENT_RPROMPT"
        # Prompt.
        "PROMPT_SUBST"
        # ZLE.
        "NO_BEEP"
      ];
    };
    # Disable command-not-found as it's unavliable in Flakes build
    command-not-found = { enable = lib.mkForce false; };
    dconf = { enable = true; };
    # Nix-Index
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    # Enable Comma
    nix-index-database.comma.enable = true;
    # Starship (Global)
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./configs/starship.toml);
    };
  };
}
