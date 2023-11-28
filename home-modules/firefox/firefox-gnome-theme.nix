{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "1208b24818388416e5376967b8e89a1b13d1bf31";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = version;
    hash = "sha256-OBik0+k54JOK9C+6AlP8dchXhAdjgP8V4mQ/ErDKGYU=";
  };

  postPatch = ''
    sed -i 4,10d userChrome.css
  '';

  # Installs to $prefix/lib
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/firefox-gnome-theme
    mv theme configuration userChrome.css userContent.css $out/lib/firefox-gnome-theme

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    description = "A GNOME theme for Firefox";
    license = with licenses; [ unlicense ];
    platforms = platforms.all;
  };
}
