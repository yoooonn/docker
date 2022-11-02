#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

image=mysql:8.0

# SH_DIR
# VOLUMES_DIR
# ROOT_DIR

container_name=mysql-l-8

docker stop "$container_name"  2>/dev/null || echo 'Running...'

docker run --rm -d -p 3307:3306 \
        --name "$container_name" \
        -e 'MYSQL_ROOT_PASSWORD=root' \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/log:/var/log/mysql \
        "$image"
