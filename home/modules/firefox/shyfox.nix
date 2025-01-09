{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "ShyFox";
  version = "dd4836fb6f93267de6a51489d74d83d570f0280d";

  src = fetchFromGitHub {
    owner = "Naezr";
    repo = pname;
    rev = version;
    hash = "sha256-7H+DU4o3Ao8qAgcYDHVScR3pDSOpdETFsEMiErCQSA8=";
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
