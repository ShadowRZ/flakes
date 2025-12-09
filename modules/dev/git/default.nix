{ config, ... }:
{
  flake.modules.homeManager = {
    dev =
      { pkgs, ... }:
      {
        programs = {
          git = {
            enable = true;
            package = pkgs.gitMinimal;
            signing = {
              signByDefault = true;
              inherit (config.flake.meta.users.shadowrz) key;
            };
            settings = {
              user = {
                inherit (config.flake.meta.users.shadowrz.git) name email;
              };
              init.defaultBranch = "master";
              sendemail.identity = "ShadowRZ";
            };
          };
          ### Delta highlighter
          delta = {
            enable = true;
            enableGitIntegration = true;
            options = {
              decorations = {
                commit-decoration-style = "bold yellow box ul";
                file-decoration-style = "none";
                file-style = "bold yellow ul";
              };
              features = "decorations";
              whitespace-error-style = "22 reverse";
            };
          };
        };
      };
  };
}
