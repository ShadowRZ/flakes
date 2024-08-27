{
  ### Basic hardening
  # ref: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/hardened.nix
  # ref: https://madaidans-insecurities.github.io/guides/linux-hardening.html
  imports = [ ./sysctl.nix ];

  security.sudo-rs.enable = true;
  security.sudo-rs.execWheelOnly = true;

  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "dccp"
    "netrom"
    "rds"
    "rose"
    "stcp"
    "tipc"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];
}
