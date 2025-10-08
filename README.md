![Hanekokoro Logo](./assets/hanekokoro-logo.svg)
# Hanekokoro (はねこころ) Infra

My personal NixOS configuration. for packages see [`github:ShadowRZ/nur-packages`](https://github.com/ShadowRZ/nur-packages)

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

## Components

* **Desktop Environment:** [KDE Plasma 6]
* **Terminal:** [Ghostty]
* **Browser:** Firefox + [Firefox GNOME Theme]
* **Shell:** [Fish] [^1] + [Starship]
* **Display Manager:** [SDDM]
* **Colorscheme:** [Catppuccin]
* **Media player:** [mpv]
* **Terminal Editor:** [Neovim], maybe explore [Helix]?
* **\[Desktop\] GUI Editor:** [VS Code] currently, have plans to build my own editor.
* **\[Desktop\] Filesystem & Encryption**: tmpfs `/`, [Btrfs] subvolumes on a [LUKS] encrypted partition for Nix Store and persisted data. Uses TPM with optional [CanoKey] support.
* **\[Desktop\] Secure Boot:** [lanzaboote]

## Config References

* [`github:drupol/infra`](https://github.com/drupol/infra) (See also: [Refactoring My Infrastructure As Code Configurations](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/))
* [`github:Guanran928/flakes`](https://github.com/Guanran928/flakes)
* [`github:Zaechus/nixos-config`](https://github.com/Zaechus/nixos-config)
* [`github:NickCao/flakes`](https://github.com/NickCao/flakes)

<!-- References -->

[KDE Plasma 6]: https://kde.org/plasma-desktop
[Ghostty]: https://ghostty.org
[Fish]: https://fishshell.com
[Starship]: https://starship.rs
[SDDM]: https://wiki.archlinux.org/title/SDDM
[Catppuccin]: https://catppuccin.com
[mpv]: https://mpv.io
[Neovim]: https://neovim.io
[Helix]: https://helix-editor.com
[VS Code]: https://code.visualstudio.com
[Btrfs]: https://btrfs.readthedocs.io
[LUKS]: https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system
[lanzaboote]: https://github.com/nix-community/lanzaboote
[CanoKey]: https://canokeys.org
[Firefox GNOME Theme]: https://github.com/rafaelmardojai/firefox-gnome-theme
