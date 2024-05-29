{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "thunderbird-gnome-theme";
  version = "966e9dd54bd2ce9d36d51cd6af8c3bac7a764a68";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = version;
    hash = "sha256-K+6oh7+J6RDBFkxphY/pzf0B+q5+IY54ZMKZrFSKXlc=";
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
