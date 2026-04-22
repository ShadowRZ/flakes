{
  flake.modules.homeManager = {
    shell = _: {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "kitty";
            source = ./logo.png;
            preserveAspectRatio = "true";
            padding = {
              top = 1;
            };
          };
          display = {
            separator = "  ";
          };
          modules = [
            "break"
            "title"
            {
              type = "os";
              key = "os    ";
              keyColor = "red";
            }
            {
              type = "kernel";
              key = "kernel";
              keyColor = "green";
            }
            {
              type = "host";
              format = "{vendor} {family}";
              key = "host  ";
              keyColor = "yellow";
            }
            {
              type = "packages";
              key = "pkgs  ";
              keyColor = "blue";
            }
            {
              type = "uptime";
              format = "{?days}{days}d {?}{hours}h {minutes}m";
              key = "uptime";
              keyColor = "magenta";
            }
            {
              type = "memory";
              key = "memory";
              keyColor = "cyan";
            }
            "break"
          ];
        };
      };
    };
  };
}
