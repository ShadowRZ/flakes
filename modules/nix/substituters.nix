{
  flake.modules = {
    nixos = {
      nix = {
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
          };
        };
      };
    };
    nixOnDroid = {
      nix =
        { lib, ... }:
        {
          # Set up nix for flakes
          nix = {
            extraOptions = ''
              experimental-features = nix-command flakes
              trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU= shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0=
            '';
            substituters = lib.mkForce [
              "https://mirrors.ustc.edu.cn/nix-channels/store"
              "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
              "https://nix-community.cachix.org"
              "https://nix-on-droid.cachix.org"
              "https://shadowrz.cachix.org"
              "https://cache.garnix.io"
              "https://cache.nixos.org"
            ];
          };
        };
    };
  };
}
