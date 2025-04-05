{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "ShyFox";
  version = "c95270d559a67becb3dad194843520766d9bbed2";

  src = fetchFromGitHub {
    owner = "ShadowRZ";
    repo = pname;
    rev = version;
    hash = "sha256-d3p3T7EdY6cL2eLVwEqU6F8cNefQ3MK4drzwrt5kpxQ=";
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
