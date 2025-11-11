{
  flake.modules.homeManager = {
    dev = _: {
      programs = {
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
