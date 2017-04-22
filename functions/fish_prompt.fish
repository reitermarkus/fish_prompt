function fish_prompt -d 'Display the command prompt'

  set -l last_status $status

  set_color normal

  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  set_color $fish_color_git
  echo -n (__fish_git_prompt)
  set_color $fish_color_normal

  if set -l ruby_version (ruby_version)
    set_color a00
    set -l ruby_icon \uE791 # NerdFonts
    echo -n " ($ruby_icon $ruby_version)"
    set_color $fish_color_normal
  end

  echo -n ' '
  not test $last_status -eq 0; and set_color $fish_color_error
  echo -n '€'
  set_color $fish_color_normal
  echo -n ' '

end
