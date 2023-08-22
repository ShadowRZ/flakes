{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "08884fb6be1c74a81f5e0a35a81c3f219e109028";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = version;
    hash = "sha256-0IS5na2WRSNWNygHhmZOcXhdrx2aFhCDQY8XVVeHf8Q=";
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
