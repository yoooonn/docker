#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

# SH_DIR
# VOLUMES_DIR
# ROOT_DIR
# G_YOO_NETWORK

for cn in "$@"
do
  docker stop "$cn" 1>/dev/null || exit 1
  docker rm "$cn" 1>/dev/null || exit 1
done
