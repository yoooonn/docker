#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

# Global variables
# SH_DIR
# ROOT_DIR
# VOLUMES_DIR
# YOO_NETWORK
# MYSQL_NETWORK
# MYSQL_ALIAS
# NACOS_ALIAS
# MYSQL_USER
# MYSQL_PASSWD
# MYSQL_PORT

container_name=mysql-l-8
image=mysql:8.0

assert_container_not_exist $container_name

create_network_if_absent "$YOO_NETWORK"

docker run -d -p "$MYSQL_PORT":3306 \
        --name "$container_name" \
        --network "$MYSQL_NETWORK" \
        --network-alias "$MYSQL_ALIAS" \
        -e "MYSQL_ROOT_PASSWORD=$MYSQL_PASSWD" \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/log:/var/log/mysql \
        "$image"
