#!/usr/bin/env bash
set -Eeu

export KOSLI_DEMO_BASE_IMAGE=ghcr.io/kosli-demo/base
export COMMIT_SHA="$(git rev-parse HEAD)"
export KOSLI_DEMO_BASE_TAG="${COMMIT_SHA:0:7}"

docker --log-level=ERROR compose build base
