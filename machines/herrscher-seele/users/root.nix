{
  home-manager = {
    users = {
      # Enables a baseline module for root
      root = {
        home = {
          username = "root";
          homeDirectory = "/root";
        };
      };
    };
  };
}
