{ lib, stdenv, fetchFromGitHub, sassc, meson, ninja }:

stdenv.mkDerivation rec {
  pname = "adw-gtk3";
  version = "f92156ba174d94a35c8f33f458aeb368c57967ef";

  src = fetchFromGitHub {
    owner = "lassekongo83";
    repo = pname;
    rev = version;
    sha256 = "sha256-2obMFLVIOsc9oU8zbKamWztKz0W03iCyRDUGVA/T3mE=";
  };

  nativeBuildInputs = [ meson ninja sassc ];

  meta = with lib; {
    description = "The theme from libadwaita ported to GTK-3";
    homepage = "https://github.com/lassekongo83/adw-gtk3";
    license = licenses.lgpl21;
    platforms = platforms.linux;
  };
}
