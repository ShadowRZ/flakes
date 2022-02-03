{ pkgs, ... }: {
  accounts.email.accounts = {
    "ShadowRZ" = {
      address = "shadowrz@disroot.org";
      gpg.key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      himalaya.enable = true;
      imap = {
        host = "disroot.org";
        tls.enable = true;
      };
      passwordCommand = "pass show ShadowRZ/Email";
      primary = true;
      realName = "夜坂雅";
      smtp = {
        host = "disroot.org";
        tls.enable = true;
      };
      userName = "shadowrz@disroot.org";
    };
  };
}
