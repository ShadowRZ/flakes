{ lib, dbus, wayland, pkg-config, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "taskmaid";
  version = "77348c92c9d975df2456426041fc00a30e1ba249";

  src = fetchFromGitHub {
    owner = "lilydjwg";
    repo = pname;
    rev = version;
    sha256 = "sha256-env0uEnz+g4wX0/w5kSgwkMWxrOkfPdpCPLHrt4V2iY=";
  };

  buildInputs = [ dbus wayland ];
  nativeBuildInputs = [ pkg-config ];

  cargoHash = "sha256-4gFLX1b6xhZC1J1ME3BPH6KLIOATM2B4xmWAjmY81uE=";

  meta = with lib; {
    description = "A D-Bus task API for Wayland";
    homepage = "https://github.com/lilydjwg/taskmaid";
    license = licenses.bsd3;
  };
}
