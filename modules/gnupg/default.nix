{
  flake.modules = {
    nixos = {
      gnupg = _: {
        services.pcscd.enable = true;
      };
    };

    homeManager = {
      gnupg =
        {
          config,
          pkgs,
          ...
        }:
        {
          ### GnuPG
          programs.gpg = {
            enable = true;
            settings = {
              personal-digest-preferences = "SHA512";
              cert-digest-algo = "SHA512";
              default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB ZIP Uncompressed";
              personal-cipher-preferences = "TWOFISH CAMELLIA256 AES 3DES";
              personal-compress-preferences = "ZLIB ZIP Uncompressed";
              keyid-format = "0xlong";
              with-fingerprint = true;
              utf8-strings = true;
              keyserver = "hkps://keys.openpgp.org";
              verbose = false;
            };
            scdaemonSettings = {
              pcsc-driver = "${pkgs.pcscliteWithPolkit.lib}/lib/libpcsclite.so";
              card-timeout = "5";
              disable-ccid = true;
            };
          };

          services = {
            ### GnuPG Agent
            gpg-agent = {
              enable = true;
              extraConfig = ''
                allow-loopback-pinentry
                allow-emacs-pinentry
              '';
              pinentry.package = pkgs.pinentry-qt;
            };
          };

          systemd.user.sessionVariables.GNUPGHOME = config.home.sessionVariables.GNUPGHOME;
        };
    };
  };
}
