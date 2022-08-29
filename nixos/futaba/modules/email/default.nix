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
      passwordCommand = "${pkgs.libsecret}/bin/secret-tool lookup email shadowrz@disroot.org";
      primary = true;
      realName = "夜坂雅";
      userName = "shadowrz@disroot.org";
    };
  };
  # Also globally enable Tools.
  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync -a"; 
        postNew = with pkgs; ''
          ${notmuch}/bin/notmuch tag +nixos -- tag:new and from:nixos1@discoursemail.com
          ${afew}/bin/afew -a -t
        '';
      };
      new.tags = [ "new" ];
    };
    afew = { enable = true; };
    alot = {
      enable = true;
      settings = {
        auto_remove_unread = true;
        handle_mouse = true;
        initial_command = "search tag:inbox AND NOT tag:killed";
        prefer_plaintext = true;
        ask_subject = false;
        thread_indent_replies = 2;
        theme = "tomorrow";
      };
    };
  };

  # Emacs Notmuch
  home.packages = with pkgs; [ notmuch.emacs ];
  # Index with CJK N-Gram
  home.sessionVariables = { XAPIAN_CJK_NGRAM = "1"; };
}
