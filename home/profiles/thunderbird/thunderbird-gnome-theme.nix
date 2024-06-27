{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "thunderbird-gnome-theme";
  version = "65d5c03fc9172d549a3ea72fd366d544981a002b";

  src = fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = pname;
    rev = version;
    hash = "sha256-nQBz2PW3YF3+RTflPzDoAcs6vH1PTozESIYUGAwvSdA=";
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
    license = with licenses; [unlicense];
    platforms = platforms.all;
  };
}
