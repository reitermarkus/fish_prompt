function python_version
    if set -q PYTHON_VERSION
        printf "$PYTHON_VERSION"
        return 0
    else if set -q VIRTUAL_ENV
        printf $(python -V 2>/dev/null | awk '{print $2}')
        return 0
    end

    return 1
end
