{
  flake.modules.homeManager = {
    shell = _: {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "iterm";
            source = ./logo.png;
            preserveAspectRatio = true;
          };
          display = {
            separator = " · ";
            color = {
              separator = "#313244";
            };
            hideCursor = true;
          };
          modules = [
            {
              type = "version";
              key = " ";
              format = "• Fastfetch {version}";
              outputColor = "bold_#fab387";
            }
            {
              type = "custom";
              key = "• Hanekokoro Infra";
              keyColor = "bold_#fab387";
              format = "https://github.com/ShadowRZ/flakes";
              outputColor = "bold_#fab387";
            }
            "break"
            {
              key = "• Host     ";
              keyColor = "#f5c2e7";
              type = "host";
            }
            {
              key = "  • Memory ";
              keyColor = "#eba0ac";
              type = "memory";
            }
            {
              key = "  • CPU    ";
              keyColor = "#cba6f7";
              type = "cpu";
            }
            {
              key = "  • GPU    ";
              keyColor = "#94e2d5";
              type = "gpu";
            }
            {
              key = "• OS       ";
              keyColor = "#89dceb";
              type = "os";
            }
            {
              key = "  • Kernel ";
              keyColor = "#a6adc8";
              type = "kernel";
            }
            {
              key = "  • Uptime ";
              keyColor = "#b4befe";
              type = "uptime";
            }
            {
              key = "• Packages ";
              keyColor = "#f9e2af";
              type = "packages";
            }
            {
              key = "• Btrfs    ";
              keyColor = "#cba6f7";
              type = "btrfs";
            }
            {
              key = "• Terminal ";
              keyColor = "#f2cdcd";
              type = "terminal";
            }
            {
              key = "  • Font   ";
              keyColor = "#6c7086";
              type = "terminalfont";
            }
            {
              key = "• Desktop  ";
              keyColor = "#74c7ec";
              type = "de";
            }
            {
              key = "  • Font   ";
              keyColor = "#6c7086";
              type = "font";
            }
            "break"
            {
              type = "colors";
              symbol = "diamond";
            }
            {
              type = "title";
              key = "The Star-Chase Nameless";
              keyColor = "bold_#fab387";
              format = "{full-user-name} ({user-name}@{host-name})";
              outputColor = "bold_#fab387";
            }
          ];
        };
      };
    };
  };
}
