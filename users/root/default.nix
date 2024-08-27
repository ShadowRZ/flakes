{
  home-manager.users.root = {
    imports = [ ../../home ];

    home = {
      username = "root";
      homeDirectory = "/root";
    };
  };
}
