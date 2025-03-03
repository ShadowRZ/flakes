{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "ShyFox";
  version = "bf2e39f9d14e4d09a616c08b0b8f9c0482e8a38b";

  src = fetchFromGitHub {
    owner = "ShadowRZ";
    repo = pname;
    rev = version;
    hash = "sha256-F7agWWtPBbKI9bIN6OSBHdjhGOD57+9lDnDLRqnFojk=";
  };

  # Installs to $prefix/lib
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/shyfox
    cp -r chrome/. $out/lib/shyfox

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/Naezr/ShyFox";
    description = "A very shy little theme that hides the entire browser interface in the window border";
    license = with licenses; [ mpl20 ];
    platforms = platforms.all;
  };
}
