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

assert_container_started "$G_MYSQL8_CONTAINER"

docker exec "$G_MYSQL8_CONTAINER" mkdir -p /home/res

docker cp "$1" "$G_MYSQL8_CONTAINER":/home/res
