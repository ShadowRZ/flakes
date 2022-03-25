pkgs: exec: with pkgs; writeShellScript "sd-runner" ''
  ${systemd}/bin/systemd-run \
    --user \
    --wait \
    --slice=session.slice \
    ${exec}
''
