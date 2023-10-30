{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "3cb70833903a560ac22f49d278e7ce955bf8395e";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = version;
    hash = "sha256-OU6LyGeePS31pG7o10su7twDzDL5Z3a1sHtV68SzEwI=";
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
