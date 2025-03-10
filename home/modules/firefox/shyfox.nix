{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "ShyFox";
  version = "a22933f6c887a5cbfc098eb8565f147f6e718c66";

  src = fetchFromGitHub {
    owner = "ShadowRZ";
    repo = pname;
    rev = version;
    hash = "sha256-tYrsIPbgpqtSwD2UGcH5kbpD1J02os51ZZH9HbNm3CA=";
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
