function __rustc_version
  if set -l rustc (command rustup which rustc 2>/dev/null)
    printf (string split ' ' ($rustc --version))[2]
    return 0
  else
    return 1
  end
end

function __rust_version_rec
    set -l current_dir $argv[1]

    if test -f "$current_dir/Cargo.toml"
        if set -l rustc_version (__rustc_version)
          printf "$rustc_version"
          return $status
        else
          command rustup install
          __rustc_version
          return $status
        end
    end

    if test "$current_dir" = /
        return 1
    end

    __rust_version_rec (dirname "$current_dir")
end

function rust_version
    command -s rustup >/dev/null; and __rust_version_rec "$PWD"
end
