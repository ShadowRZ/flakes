{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      programs = {
        git = {
          enable = true;
          package = pkgs.gitMinimal;
          settings = {
            signing = {
              key = "AC597AD389D1CC5618AD1ED9B7123A2B6B0AE434";
            };
            user = {
              name = "Yorusaka Miyabi";
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
        ### Gh
        gh = {
          enable = true;
          settings = {
            git_protocol = "ssh";
            version = "1";
          };
        };
      };
    };
}
