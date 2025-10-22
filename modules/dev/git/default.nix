{ config, ... }:
{
  flake.modules.homeManager = {
    dev =
      { pkgs, ... }:
      {
        programs = {
          git = {
            enable = true;
            package = pkgs.gitFull;
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
          ### Gh
          gh = {
            enable = true;
            settings = {
              git_protocol = "ssh";
              version = "1";
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
          ### Git Cliff
          git-cliff = {
            enable = true;
            settings = {
              changelog = {
                header = "Changelog";
                trim = true;
              };
              bump = {
                features_always_bump_minor = true;
                breaking_always_bump_major = true;
                initial_tag = "0.1.0";
              };
              git = {
                conventional_commits = true;
                filter_unconventional = false;
                commit_parsers = [
                  {
                    message = ".*";
                    group = "Other";
                    default_scope = "other";
                  }
                ];
              };
            };
          };
        };
      };
  };
}
