{
  flake.modules = {
    nixos = {
      shell =
        _:
        {
          programs.ssh.startAgent = true;
        };
    };

    homeManager = {
      shell =
        _:
        {
          services.ssh-agent.enable = true;
        };
    };
  };
}
