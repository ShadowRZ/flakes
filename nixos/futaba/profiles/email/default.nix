{ pkgs, ... }: {
  accounts.email.accounts = {
    "ShadowRZ" = {
      address = "shadowrz@disroot.org";
      gpg.key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      himalaya.enable = true;
      imap = {
        host = "disroot.org";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "disroot.org";
        port = 465;
        tls.enable = true;
      };
      passwordCommand = "pass show ShadowRZ/Email";
      primary = true;
      realName = "夜坂雅";
      userName = "shadowrz@disroot.org";
    };
  };
  # Also globally enable Himalaya.
  programs.himalaya.enable = true;
}
