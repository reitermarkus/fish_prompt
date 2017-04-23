function __git_prompt
  git_is_repo; or return 1

  if set -l branch_name (git_branch_name)
    set -l branch_symbol \uE0A0

    if git_is_detached_head
      set branch_symbol \uF417
    end

    set_color normal $fish_color_git
    echo -n " ($branch_symbol $branch_name"

    if git_is_dirty
      printf '✲'
    end

    set -l git_ahead (git_ahead)
    switch "$git_ahead"
      case '+'
        printf ' '
        set_color 095
        printf '↑'
      case '-'
        printf ' '
        set_color a00
        printf '↓'
      case '±'
        printf ' '
        set_color 095
        printf '↑'
        set_color a00
        printf '↓'
    end

    set_color normal
    set_color $fish_color_git
    echo -n ')'
    set_color normal
  end
end

function fish_prompt -d 'Display the command prompt'

  set -l last_status $status

  set_color normal

  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color $fish_color_normal

  __git_prompt

  if set -l ruby_version (ruby_version)
    set_color a00
    set -l ruby_icon \uE791 # NerdFonts
    echo -n " ($ruby_icon $ruby_version)"
    set_color $fish_color_normal
  end

  echo -n ' '
  set_color $fish_color_normal
  not test $last_status -eq 0; and set_color $fish_color_error
  echo -n '€'
  set_color $fish_color_normal
  echo -n ' '

end
