{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }: {
  "redirector" = buildFirefoxXpiAddon {
    pname = "redirector";
    version = "3.5.3";
    addonId = "redirector@einaregilsson.com";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3535009/redirector-3.5.3.xpi";
    sha256 = "eddbd3d5944e748d0bd6ecb6d9e9cf0e0c02dced6f42db21aab64190e71c0f71";
    meta = with lib; {
      homepage = "http://einaregilsson.com/redirector/";
      description =
        "Automatically redirects to user-defined urls on certain pages";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };
}
