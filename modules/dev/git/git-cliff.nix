{
  flake.modules.homeManager = {
    dev = {
      programs = {
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
