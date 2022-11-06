#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals


docker build -t yooonn/nacos-server:v2.1.2 -f "$ROOT_DIR"/dockerfile/nacos/Dockerfile "$ROOT_DIR"/dockerfile/nacos
