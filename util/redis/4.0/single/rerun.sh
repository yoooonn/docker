#!/usr/bin/env bash
# author yooonn

set -eu

. ./globals

image=redis:4.0.14-alpine

container_name=rd-l-4

docker stop "$container_name"  2>/dev/null || echo 'Running...'

docker run --rm -d -p 6382:6379 \
        --name "$container_name" \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data:/data \
        "$image"
