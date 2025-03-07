{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "ShyFox";
  version = "a03da3d563b0abd8b8a15af0bc85ca8561e02b54";

  src = fetchFromGitHub {
    owner = "ShadowRZ";
    repo = pname;
    rev = version;
    hash = "sha256-afK32acu4zp6bHa+qnq4vstq3tsORHTnPdlrjZ9p5Vk=";
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
