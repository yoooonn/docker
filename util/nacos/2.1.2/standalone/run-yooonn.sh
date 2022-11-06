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

container_name=nacos
image=yooonn/nacos-server:v2.1.2

assert_container_not_exist $container_name

create_network_if_absent "$MYSQL_NETWORK"

docker run -d \
  -p 18848:8848 \
  -p 19848:9848 \
  -p 19555:9555 \
  --name "$container_name" \
  --network "$MYSQL_NETWORK" \
  --network-alias "$NACOS_ALIAS" \
  --link mysql-l-8:mysql8 \
  -v "$VOLUMES_DIR"/"$SH_DIR"/c-standalone-logs/:/opt/nacos-server/nacos/logs \
  "$image"
#  -v "$VOLUMES_DIR"/"$SH_DIR"/c-conf/:/opt/nacos-server/nacos/conf \
