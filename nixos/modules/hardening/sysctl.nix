{
  boot.kernel.sysctl = {
    ### https://madaidans-insecurities.github.io/guides/linux-hardening.html#sysctl
    # Kernel self-protection
    "kernel.kptr_restrict" = "2";
    "kernel.dmesg_restrict" = "1";
    "kernel.printk" = "3 3 3 3";
    "kernel.unprivileged_bpf_disabled" = "1";
    "net.core.bpf_jit_harden" = "2";
    "dev.tty.ldisc_autoload" = "0";
    "vm.unprivileged_userfaultfd" = "0";
    "kernel.kexec_load_disabled" = "1";
    "kernel.sysrq" = "4";
    "kernel.perf_event_paranoid" = "3";

    # Network
    "net.ipv4.tcp_syncookies" = "1";
    "net.ipv4.tcp_rfc1337" = "1";
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.rp_filter" = "1";
    "net.ipv4.conf.all.accept_redirects" = "0";
    "net.ipv4.conf.default.accept_redirects" = "0";
    "net.ipv4.conf.all.secure_redirects" = "0";
    "net.ipv4.conf.default.secure_redirects" = "0";
    "net.ipv6.conf.all.accept_redirects" = "0";
    "net.ipv6.conf.default.accept_redirects" = "0";
    "net.ipv4.conf.all.send_redirects" = "0";
    "net.ipv4.conf.default.send_redirects" = "0";
    "net.ipv4.icmp_echo_ignore_all" = "1";
    "net.ipv4.conf.all.accept_source_route" = "0";
    "net.ipv4.conf.default.accept_source_route" = "0";
    "net.ipv6.conf.all.accept_source_route" = "0";
    "net.ipv6.conf.default.accept_source_route" = "0";
    "net.ipv6.conf.all.accept_ra" = "0";
    "net.ipv6.conf.default.accept_ra" = "0";
    "net.ipv4.tcp_sack" = "0";
    "net.ipv4.tcp_dsack" = "0";
    "net.ipv4.tcp_fack" = "0";

    # User Space
    "kernel.yama.ptrace_scope" = "1"; # was 2
    "vm.mmap_rnd_bits" = "32";
    "vm.mmap_rnd_compat_bits" = "16";
    "fs.protected_symlinks" = "1";
    "fs.protected_hardlinks" = "1";
    "fs.protected_fifos" = "2";
    "fs.protected_regular" = "2";
  };
}
