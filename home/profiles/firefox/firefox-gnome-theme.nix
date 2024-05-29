{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "1efffcaa78904816f70dd493627412d299b23a52";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = version;
    hash = "sha256-JouEEHCgFk9WMAi1VFqNP+Ow5I5NFD+B2+3E6BG1Y3c=";
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
