#!/usr/bin/env bash
set -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PORT=4530

export RUBYOPT='-W2 --enable-frozen-string-literal'

puma \
  --port=${PORT} \
  --config=${MY_DIR}/puma.rb

