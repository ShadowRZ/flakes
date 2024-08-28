# Codename Hanekokoro

My personal NixOS configuration. for packages see [`github:ShadowRZ/nur-packages`](https://github.com/ShadowRZ/nur-packages)

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

## Components

* **Desktop Environment:** [KDE Plasma 6]
* **Terminal:** [Kitty]
* **Shell:** [Zsh] [^1] + [Starship]
* **Display Manager:** [SDDM]
* **Colorscheme:** [Rosé Pine]
* **Media player:** [mpv]
* **Terminal Editor:** [Neovim]
* **\[Desktop\] Filesystem & Encryption**: tmpfs `/`, [Btrfs] subvolumes on a [LUKS] encrypted partition for Nix Store and persisted data. Uses a passphrase to unlock. [^2]
* **\[Desktop\] Secure Boot:** [lanzaboote]

[^1]: Yes I'm still somewhat oldschool and uses a `sh` compatible shell.
[^2]: For unknown reason, FIDO2 unlocking failed to work for me despite I have a compatible FIDO2 device ([CanoKey]).

## Config References

* [`github:Guanran928/flakes`](https://github.com/Guanran928/flakes)
* [`github:Zaechus/nixos-config`](https://github.com/Zaechus/nixos-config)
* [`github:NickCao/flakes`](https://github.com/NickCao/flakes)

<!-- References -->

[KDE Plasma 6]: https://kde.org/plasma-desktop
[Kitty]: https://sw.kovidgoyal.net/kitty/
[Zsh]: https://zsh.sourceforge.io
[Starship]: https://starship.rs
[SDDM]: https://wiki.archlinux.org/title/SDDM
[Rosé Pine]: https://rosepinetheme.com
[mpv]: https://mpv.io
[Neovim]: https://neovim.io
[Btrfs]: https://btrfs.readthedocs.io
[LUKS]: https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system
[lanzaboote]: https://github.com/nix-community/lanzaboote
[CanoKey]: https://canokeys.org
