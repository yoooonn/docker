#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

# SH_DIR
# VOLUMES_DIR
# ROOT_DIR
# YOO_NETWORK

for cn in "$@"
do
  restart_container "$cn"
done
