{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./style.css;
    settings = [ (import ./config.nix pkgs) ];
  };
  systemd.user.services = {
    # Taskmaid
    taskmaid = {
      Unit = {
        Description = "Taskmaid";
        Documentation = "https://github.com/lilydjwg/taskmaid";
        PartOf = "graphical-session.target";
      };
      Service.ExecStart = "${pkgs.taskmaid}/bin/taskmaid";
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
