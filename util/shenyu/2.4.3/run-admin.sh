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

container_name=syadmin
image=apache/shenyu-admin:2.4.3

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
  -e MYSQL_SERVICE_HOST="$G_MYSQL8_ALIAS" \
  -e MYSQL_SERVICE_PORT=3306 \
  -e MYSQL_SERVICE_USER="$MYSQL_USER" \
  -e MYSQL_SERVICE_PASSWORD="$MYSQL_PASSWD" \
  -e MYSQL_SERVICE_DB_NAME=nacos_devtest \
  -v "$VOLUMES_DIR"/"$SH_DIR"/standalone-logs/:/home/nacos/logs \
  "$image"
#  -v "$VOLUMES_DIR"/"$SH_DIR"/conf/:/home/nacos/conf \
