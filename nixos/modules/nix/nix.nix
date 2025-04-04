{
  # Configure Nix.
  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store?priority=10"
        "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store?priority=10"
        "https://shadowrz.cachix.org?priority=20"
        "https://nix-community.cachix.org?priority=20"
        "https://cache.garnix.io?priority=30"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      builders-use-substitutes = true;
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
      keep-derivations = true;
      experimental-features = [
        "ca-derivations"
        "auto-allocate-uids"
        "cgroups"
      ];
      auto-allocate-uids = true;
      use-cgroups = true;
      use-xdg-base-directories = true;
      http-connections = 0;
      max-substitution-jobs = 128;
    };
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
  };
}
