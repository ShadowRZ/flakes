{ pkgs, ... }: {
  accounts.email.accounts = {
    "ShadowRZ" = {
      address = "shadowrz@disroot.org";
      gpg.key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      msmtp = { enable = true; };
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
      astroid = { enable = true; };
      imap = {
        host = "disroot.org";
        port = 993;
        tls.enable = true;
      };
      notmuch = { enable = true; };
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
  # Also globally enable Tools.
  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
    astroid.enable = true;
    notmuch = {
      enable = true;
      hooks = { preNew = "mbsync -a"; };
      new.tags = [ "new" ];
    };
    afew = { enable = true; };
    alot.enable = true;
  };

  # Mu & mu4e
  home.packages = with pkgs; [ mu ];
  home.sessionVariables = { XAPIAN_CJK_NGRAM = "1"; };
}
