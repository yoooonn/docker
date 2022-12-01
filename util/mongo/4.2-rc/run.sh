#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

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

image=mongo:4.2-rc
container_name=mongo

assert_container_not_exist smysql

docker run -d \
        -p 27017:27017 \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/data/db \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/configdb:/data/configdb \
        --name "$container_name" \
        "$image"
