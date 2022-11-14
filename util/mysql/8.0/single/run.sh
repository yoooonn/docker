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

container_name=$G_MYSQL8_CONTAINER
image=mysql:8.0

while getopts :f OPT ; do
  case $OPT in
  f)
    docker stop "$container_name" 1>/dev/null || exit 1
    docker rm "$container_name" 1>/dev/null || exit 1
    ;;
  ?)
  esac
done

assert_container_not_exist "$container_name"

create_network_if_absent "$G_MYSQL_NETWORK"

docker run -d -p "$G_MYSQL8_PORT":3306 \
        --network "$G_MYSQL_NETWORK" \
        --network-alias "$G_MYSQL8_ALIAS" \
        -e "MYSQL_ROOT_PASSWORD=$G_MYSQL_PASSWD" \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$SH_DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$SH_DIR"/log:/var/log/mysql \
        --name "$container_name" \
        "$image"
