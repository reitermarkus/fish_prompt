function ruby_version
    if set -q RUBY_VERSION
        printf "$RUBY_VERSION"
        return 0
    else if command -s rbenv >/dev/null
        set -l rbenv_root (rbenv root)
        set -l rbenv_version_origin (rbenv version-origin)

        if not test "$rbenv_root/version" = "$rbenv_version_origin"
            printf (rbenv version-name 2>/dev/null)
            return $status
        end
    end

    return 1
end
