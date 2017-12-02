function __rust_version_rec
  set -l current_dir $argv[1]

  if test -f "$current_dir/Cargo.toml"
    printf (string split ' ' (eval (rustup which rustc) --version))[2]
    return 0
  end

  if test "$current_dir" = /
    return 1
  end

  __rust_version_rec (dirname "$current_dir")
end

function rust_version
  command -s rustup > /dev/null; and __rust_version_rec "$PWD"
end
