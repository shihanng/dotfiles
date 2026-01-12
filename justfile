lint:
    #!/usr/bin/env bash
    set -euxo pipefail
    luacheck .
    stylua -g "**/*.lua" .
    prettier -v --check .
    sort-lines ./home/dot_config/mise/config.toml
    taplo fmt --check
    just --fmt --check --unstable
