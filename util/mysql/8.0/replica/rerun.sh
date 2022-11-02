#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

image=mysql:8.0

# ROOT_DIR
# VOLUMES_DIR

docker network create mysql-cluster >/dev/null 2>&1 || echo 'Network 'mysql-cluster' already exist. Skip create it.'

docker stop mmysql smysql 2>/dev/null || echo 'Running...'

docker run --rm -d -p 13306:3306 \
        --name mmysql \
        --network mysql-cluster \
        --network-alias mmysql \
        -e 'MYSQL_ROOT_PASSWORD=root' \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/log:/var/log/mysql \
        "$image"

docker run --rm -d -p 13307:3306 \
        --name smysql \
        --network mysql-cluster \
        --network-alias smysql \
        -e 'MYSQL_ROOT_PASSWORD=root' \
        -v "$VOLUMES_DIR"/"$SH_DIR"/sdata/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/sdata/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/slog:/var/log/mysql \
        "$image" \
        mysqld --skip-slave-start --character-set-server=utf8 --collation-server=utf8_unicode_ci
