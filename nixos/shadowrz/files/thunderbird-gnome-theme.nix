{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "thunderbird-gnome-theme";
  version = "a899ca12204d19f4834fbd092aa5bb05dc4bd127";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = version;
    hash = "sha256-3TQYBJAeQ2fPFxQnD5iKRKKWFlN3GJhz1EkdwE+4m0k=";
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
