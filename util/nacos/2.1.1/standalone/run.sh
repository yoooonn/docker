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
image=nacos/nacos-server:v2.1.1-slim

assert_container_not_exist $container_name

create_network_if_absent "$MYSQL_NETWORK"

docker run -d \
  -p 8848:8848 \
  -p 9848:9848 \
  -p 9555:9555 \
  --name "$container_name" \
  --network "$MYSQL_NETWORK" \
  --network-alias "$NACOS_ALIAS" \
  -e PREFER_HOST_MODE=hostname \
  -e MODE=standalone \
  -e SPRING_DATASOURCE_PLATFORM=mysql \
  -e MYSQL_SERVICE_HOST="$MYSQL_ALIAS" \
  -e MYSQL_SERVICE_PORT="$MYSQL_PORT" \
  -e MYSQL_SERVICE_USER="$MYSQL_USER" \
  -e MYSQL_SERVICE_PASSWORD="$MYSQL_PASSWD" \
  -e MYSQL_SERVICE_DB_NAME=nacos_devtest \
  -v "$VOLUMES_DIR"/"$SH_DIR"/standalone-logs/:/home/nacos/logs \
  -v "$VOLUMES_DIR"/"$SH_DIR"/conf/:/home/nacos/conf \
  "$image"
