#!/usr/bin/env bash

set -eu
. ./globals

# Global variables
# SH_DIR
# ROOT_DIR
# VOLUMES_DIR
# G_YOO_NETWORK
# G_MYSQL_NETWORK
# G_MYSQL8_ALIAS
# G_MYSQL8_CONTAINER
# G_NACOS_ALIAS
# G_MYSQL_USER
# G_MYSQL_PASSWD
# G_MYSQL8_PORT

target_network=mysql-cluster

create_network_if_absent $target_network

assert_container_not_exist mmysql

assert_container_not_exist smysql

docker run -d -p 13306:3306 \
        --name mmysql \
        --network $target_network \
        --network-alias mmysql \
        -e 'MYSQL_ROOT_PASSWORD=root'\
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/log:/var/log/mysql \
        mysql:5.7


docker run -d -p 13307:3306 \
        --name smysql \
        --network $target_network \
        --network-alias smysql \
        -e 'MYSQL_ROOT_PASSWORD=root'\
        -v "$VOLUMES_DIR"/"$SH_DIR"/sdata/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/sdata/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/slog:/var/log/mysql \
        mysql:5.7 \
        mysqld --skip-slave-start --character-set-server=utf8mb4 --collation-server=utf8_unicode_ci