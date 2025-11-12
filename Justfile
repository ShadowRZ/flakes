update:
  nix --extra-experimental-features 'nix-command flakes' flake update --verbose -L --commit-lock-file

format:
  nix --extra-experimental-features 'nix-command flakes' fmt --verbose -L
