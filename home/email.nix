{ pkgs, ... }: {
  programs = {
    ### Mbsync
    mbsync.enable = true;
    ### Notmuch
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync -a";
        postNew = "${pkgs.afew}/bin/afew -a -t";
      };
      new.tags = [ "new" ];
    };
    ### Neomutt
    neomutt = {
      enable = true;
      sidebar = {
        enable = true;
        width = 26;
      };
      vimKeys = true;
      extraConfig = builtins.readFile ./files/neomutt.muttrc;
    };
    ### Afew
    afew = {
      enable = true;
      extraConfig = builtins.readFile ./files/afew.config;
    };
  };
  accounts.email.accounts = {
    "ShadowRZ" = {
      address = "shadowrz@disroot.org";
      gpg.key = "3237D49E8F815A45213364EA4FF35790F40553A9";
      msmtp.enable = true;
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
      notmuch = {
        enable = true;
        neomutt = {
          enable = true;
          virtualMailboxes = [{
            name = "Nixpkgs";
            query = "tag:nixpkgs";
            type = "threads";
          }];
        };
      };
      smtp = {
        host = "disroot.org";
        port = 465;
        tls.enable = true;
      };
      passwordCommand =
        "${pkgs.libsecret}/bin/secret-tool lookup email shadowrz@disroot.org";
      primary = true;
      realName = "夜坂雅";
      userName = "shadowrz@disroot.org";
      neomutt = { enable = true; };
    };
  };
}
