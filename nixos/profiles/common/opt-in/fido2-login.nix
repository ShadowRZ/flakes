{pkgs, ...}: {
  security.pam = {
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
    u2f = {
      enable = true;
      control = "sufficient";
      cue = true;
    };
  };

  services.udev.packages = [pkgs.libfido2];
}
