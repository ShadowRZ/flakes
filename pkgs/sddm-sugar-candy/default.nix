{ lib, stdenv, fetchgit }:

stdenv.mkDerivation rec {
  pname = "sddm-sugar-candy";
  version = "2b72ef6c6f720fe0ffde5ea5c7c48152e02f6c4f";

  src = fetchgit {
    url = "https://framagit.org/MarianArlt/sddm-sugar-candy";
    rev = version;
    sha256 = "sha256-XggFVsEXLYklrfy1ElkIp9fkTw4wvXbyVkaVCZq4ZLU=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/sugar-candy
    cp -vr * $out/share/sddm/themes/sugar-candy
  '';

  meta = with lib; {
    description = "The sweetest login theme avaliable for SDDM";
    homepage = "https://framagit.org/MarianArlt/sddm-sugar-candy";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
