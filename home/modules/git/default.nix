{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      # Basic
      userEmail = "23130178+ShadowRZ@users.noreply.github.com";
      userName = "夜坂雅";
      signing = {
        signByDefault = true;
        key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      };
      # Delta highlighter
      delta = {
        enable = true;
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
      extraConfig = {
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
}
