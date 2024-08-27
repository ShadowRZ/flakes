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
      default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
      personal-cipher-preferences = "TWOFISH CAMELLIA256 AES 3DES";
      keyid-format = "0xlong";
      with-fingerprint = true;
      trust-model = "tofu";
      utf8-strings = true;
      keyserver = "hkps://keys.openpgp.org";
      verbose = false;
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
      pinentryPackage = pkgs.pinentry-qt;
    };
  };

  systemd.user.sessionVariables.GNUPGHOME = config.home.sessionVariables.GNUPGHOME;
}
