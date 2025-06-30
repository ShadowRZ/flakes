{
  flake.modules.nixos = {
    base = {
      i18n = {
        defaultLocale = "C.UTF-8";
        # Build all Glibc supported locales as defined in:
        # https://sourceware.org/git/?p=glibc.git;a=blob;f=localedata/SUPPORTED
        supportedLocales = [
          "C.UTF-8/UTF-8"
          "en_US.UTF-8/UTF-8"
          "zh_CN.UTF-8/UTF-8"
        ];
      };
    };
  };
}
