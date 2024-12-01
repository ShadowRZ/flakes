{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "c1d082e47cb38b9e8d8d6899398f3bae51a72c34";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = version;
    hash = "sha256-Hf2NK58bTV1hy6FxvKpyNzm59tyMPzDjc8cGcWiTLyQ=";
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
