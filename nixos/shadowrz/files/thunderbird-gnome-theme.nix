{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "thunderbird-gnome-theme";
  version = "3df2e63b4818cf78b4bd8408763638b907df372b";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = version;
    hash = "sha256-KwjdXFyrorAXiOQnAsqKOatpRaKTuVTnLfs4xOLe3PY=";
  };

  postPatch = ''
    sed -i 4,10d userChrome.css
  '';

  # Installs to $prefix/lib
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/${pname}
    mv theme configuration userChrome.css userContent.css $out/lib/${pname}

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/rafaelmardojai/thunderbird-gnome-theme";
    description = "A GNOME theme for Thunderbird";
    license = with licenses; [ unlicense ];
    platforms = platforms.all;
  };
}
