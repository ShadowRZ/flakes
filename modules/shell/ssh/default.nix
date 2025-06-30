{
  flake.modules = {
    nixos = {
      shell = {
        programs.ssh.startAgent = true;
      };
    };

    homeManager = {
      shell = {
        services.ssh-agent.enable = true;
      };
    };
  };
}
