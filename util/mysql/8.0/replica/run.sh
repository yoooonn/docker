#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

# ROOT_DIR
# VOLUMES_DIR

image=mysql:8.0
target_network=mysql-cluster

create_network_if_absent $target_network

assert_container_not_exist mmysql8
assert_container_not_exist smysql8

docker run -d -p 23306:3306 \
        --name mmysql8 \
        --network $target_network \
        --network-alias mmysql8 \
        -e 'MYSQL_ROOT_PASSWORD=root' \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/log:/var/log/mysql \
        "$image"

docker run -d -p 23307:3306 \
        --name smysql8 \
        --network $target_network \
        --network-alias smysql8 \
        -e 'MYSQL_ROOT_PASSWORD=root' \
        -v "$VOLUMES_DIR"/"$SH_DIR"/sdata/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/sdata/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/slog:/var/log/mysql \
        "$image" \
        mysqld --skip-slave-start --character-set-server=utf8mb4 --collation-server=utf8_unicode_ci
