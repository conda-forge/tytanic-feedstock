#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ "${target_platform}" == linux-* ]]; then
    export OPENSSL_DIR=$PREFIX
fi

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY_LICENSES.yaml

cargo install --no-track --locked --root "$PREFIX" --path crates/tytanic

"$STRIP" "$PREFIX/bin/tt"

mkdir -p $PREFIX/share/zsh/site-functions $PREFIX/share/bash-completion/completions $PREFIX/share/fish/vendor_completions.d
$PREFIX/bin/tt util completion bash > $PREFIX/share/bash-completion/completions/tt
$PREFIX/bin/tt util completion zsh > $PREFIX/share/zsh/site-functions/_tt
$PREFIX/bin/tt util completion fish > $PREFIX/share/fish/vendor_completions.d/tt.fish
