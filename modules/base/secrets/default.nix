{ inputs, ... }:
{
  flake.modules.nixos = {
    base =
      { config, ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        sops = {
          defaultSopsFile = ./secrets.yaml;
          age = {
            keyFile = "/var/lib/sops.key";
            sshKeyPaths = [ ];
          };
          gnupg.sshKeyPaths = [ ];

          secrets = {
            passwd = {
              neededForUsers = true;
            };
          };
        };
      };
  };
}
