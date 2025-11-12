function fish_title
  if set -q argv[1]
    echo $USER@$hostname: $argv;
  else
    echo $USER@$hostname: (fish_prompt_pwd_dir_length=0 prompt_pwd);
  end
end

function fish_greeting
  if test -n "$ZELLIJ"
    echo (set_color brcyan -o)Fish $version
    echo (set_color brmagenta -o)"Belongs to Hanekokoro Infra (https://github.com/ShadowRZ/flakes)"
  else
    fastfetch
  end
end
