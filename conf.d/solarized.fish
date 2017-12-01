# Solarized

if test "$TERM_PROGRAM" = Apple_Terminal

  # List Colors

  set -g LSCOLORS dxfxcxdxbxegedabagacad


  # Colors

  set -l base03  black
  set -l base02  black  --bold
  set -l base01  green  --bold
  set -l base00  yellow --bold
  set -l base0   blue   --bold
  set -l base1   cyan   --bold
  set -l base2   white
  set -l base3   white  --bold
  set -l yellow  yellow
  set -l orange  red    --bold
  set -l red     red
  set -l magenta purple
  set -l violet  purple --bold
  set -l blue    blue
  set -l cyan    cyan
  set -l green   green

  set -g fish_color_autosuggestion    $magenta
  set -g fish_color_command           $green
  set -g fish_color_comment           $base01
  set -g fish_color_cwd               $yellow
  set -g fish_color_cwd_root          $red
  set -g fish_color_end               $base0
  set -g fish_color_error             $red
  set -g fish_color_escape            $magenta
  set -g fish_color_history_current   $fish_color_cwd
  set -g fish_color_host              $cyan
  set -g fish_color_match             $cyan
  set -g fish_color_normal            $base03
  set -g fish_color_param             $cyan
  set -g fish_color_operator          $violet
  set -g fish_color_quote             $cyan
  set -g fish_color_redirection       $violet
  set -g fish_color_search_match      --background=$base2
  set -g fish_color_selection         --background=$base2
  set -g fish_color_user              $base01
  set -g fish_color_valid_path        $cyan --underline

  set -g fish_pager_color_completion  normal
  set -g fish_pager_color_description $yellow
  set -g fish_pager_color_prefix      $cyan
  set -g fish_pager_color_progress    $red

  set -g fish_color_git               $orange

end
