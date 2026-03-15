{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      programs = {
        git = {
          enable = true;
          package = pkgs.gitMinimal;
          signing = {
            signByDefault = true;
            key = "AC597AD389D1CC5618AD1ED9B7123A2B6B0AE434";
          };
          settings = {
            user = {
              name = "夜坂雅";
              email = "23130178+ShadowRZ@users.noreply.github.com";
            };
            init.defaultBranch = "master";
          };
          lfs = {
            enable = true;
            skipSmudge = true;
          };
        };
        ### Delta highlighter
        delta = {
          enable = true;
          enableGitIntegration = true;
        };
        ### Gh
        gh = {
          enable = true;
          settings = {
            git_protocol = "ssh";
            version = "1";
          };
        };
        gh-dash = {
          enable = true;
        };
      };
    };
}
