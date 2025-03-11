function __git_operation
    set -l git_dir $argv[1]

    set -l operation
    set -l step
    set -l total

    if test -d $git_dir/rebase-merge
        set branch (cat $git_dir/rebase-merge/head-name 2>/dev/null)
        set step (cat $git_dir/rebase-merge/msgnum 2>/dev/null)
        set total (cat $git_dir/rebase-merge/end 2>/dev/null)
        if test -f $git_dir/rebase-merge/interactive
            set operation rebase-i
        else
            set operation rebase-m
        end
    else
        if test -d $git_dir/rebase-apply
            set step (cat $git_dir/rebase-apply/next 2>/dev/null)
            set total (cat $git_dir/rebase-apply/last 2>/dev/null)
            if test -f $git_dir/rebase-apply/rebasing
                set branch (cat $git_dir/rebase-apply/head-name 2>/dev/null)
                set operation rebase
            else if test -f $git_dir/rebase-apply/applying
                set operation am
            else
                set operation am/rebase
            end
        else if test -f $git_dir/MERGE_HEAD
            set operation merging
        else if test -f $git_dir/CHERRY_PICK_HEAD
            set operation cherry-picking
        else if test -f $git_dir/REVERT_HEAD
            set operation reverting
        else if test -f $git_dir/BISECT_LOG
            set operation bisecting
        end
    end

    if test -n "$step" -a -n "$total"
        set operation "$operation $step/$total"
    end

    if test -z "$operation"
        return 1
    end

    printf $operation
end

function __git_prompt
    not command -s git >/dev/null
    and return 1

    set -l repo_info (command git rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree HEAD 2>/dev/null)

    test -n "$repo_info"
    or return

    set -l git_dir $repo_info[1]
    set -l inside_gitdir $repo_info[2]
    set -l bare_repo $repo_info[3]
    set -l inside_worktree $repo_info[4]

    if set -l branch_name (git_branch_name)
        set -l branch_symbol \uE0A0

        if git_is_detached_head
            set branch_symbol \uF417
        end

        set_color normal $fish_color_git

        echo -n " ($branch_symbol "

        if test true = $inside_gitdir
            if test true = $bare_repo
                echo -n "bare|"
            else
                # Let user know they're inside the git dir of a non-bare repo
                echo -n ".git|"
            end
        end

        echo -n "$branch_name"

        if git_is_dirty
            printf '✲'
        end

        if set -l operation (__git_operation $git_dir)
            printf "|$operation"
        end

        set -l git_ahead (git_ahead)
        switch "$git_ahead"
            case '+'
                printf ' '
                set_color 095
                printf '↑'
            case -
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

    if set -l python_version (python_version)
        set_color 4584b6
        set -l python_icon \uE235 # NerdFonts
        echo -n " ($python_icon $python_version"

        if set -q VIRTUAL_ENV
          echo -n " $(basename $VIRTUAL_ENV)"
        end

        echo -n ")"

        set_color $fish_color_normal
    end

    if set -l ruby_version (ruby_version)
        set_color a00
        set -l ruby_icon \uE791 # NerdFonts
        echo -n " ($ruby_icon $ruby_version)"
        set_color $fish_color_normal
    end

    if set -l rust_version (rust_version)
        set_color 875f5f
        set -l rust_icon \uE7A8 # NerdFonts
        echo -n " ($rust_icon $rust_version)"
        set_color $fish_color_normal
    end

    echo -n ' '
    set_color $fish_color_normal
    not test $last_status -eq 0; and set_color $fish_color_error
    echo -n '€'
    set_color $fish_color_normal
    echo -n ' '
end
