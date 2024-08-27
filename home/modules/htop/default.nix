{
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
      hide_running_in_container = false;
      shadow_other_users = true;
      show_thread_names = true;
      show_program_path = true;
      highlight_base_name = true;
      highlight_deleted_exe = true;
      shadow_distribution_path_prefix = true;
      highlight_megabytes = true;
      highlight_threads = true;
      highlight_changes = true;
      highlight_changes_delay_secs = 5;
      find_comm_in_cmdline = true;
      strip_exe_from_cmdline = true;
      enable_mouse = true;
      tree_view = true;
    };
  };
}
