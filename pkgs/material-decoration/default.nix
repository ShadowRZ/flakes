{ stdenv, fetchFromGitHub, cmake, extra-cmake-modules, qt5, plasma5Packages }:
qt5.mkDerivation {
  pname = "material-decoration";
  version = "cc5cc399a546b66907629b28c339693423c894c8";
  src = fetchFromGitHub ({
    owner = "Zren";
    repo = "material-decoration";
    rev = "cc5cc399a546b66907629b28c339693423c894c8";
    fetchSubmodules = false;
    sha256 = "sha256-aYlnPFhf+ISVe5Ycryu5BSXY8Lb5OoueMqnWQZiv6Lc=";
  });
  buildInputs = with plasma5Packages; [ qt5.qtbase qt5.qtx11extras kwayland kdecoration kcoreaddons kguiaddons kconfig kconfigwidgets kwindowsystem kiconthemes ];
  nativeBuildInputs = [ cmake extra-cmake-modules ];
}
