update:
  nix --extra-experimental-features 'nix-command flakes' flake update --verbose -L --commit-lock-file

format:
  nix --extra-experimental-features 'nix-command flakes' fmt --verbose -L

build:
  nix build --verbose -L "{{ `nix eval .#nixosConfigurations.herrscher-seele.config.system.build.toplevel.outPath --raw` }}" --no-link

switch: build
  nh os switch .
