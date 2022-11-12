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

container_name=nacos
image=nacos/nacos-server:v2.1.2-slim
db=nacos_devtest

while getopts :f OPT ; do
  case $OPT in
  f)
    docker stop $container_name 1>/dev/null || exit 1
    docker rm $container_name 1>/dev/null || exit 1
    ;;
  ?)
  esac
done

assert_container_not_exist $container_name

create_network_if_absent "$G_MYSQL_NETWORK"

docker run -d \
  -p 8848:8848 \
  -p 9848:9848 \
  -p 9555:9555 \
  --network "$G_MYSQL_NETWORK" \
  --network-alias "$G_NACOS_ALIAS" \
  -e MODE=standalone \
  -e SPRING_DATASOURCE_PLATFORM=mysql \
  -e MYSQL_SERVICE_HOST="$G_MYSQL8_ALIAS" \
  -e MYSQL_SERVICE_PORT=3306 \
  -e MYSQL_SERVICE_USER="$G_MYSQL_USER" \
  -e MYSQL_SERVICE_PASSWORD="$G_MYSQL_PASSWD" \
  -e MYSQL_SERVICE_DB_NAME="$db" \
  -e "MYSQL_SERVICE_DB_PARAM=allowPublicKeyRetrieval=true&characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useSSL=false" \
  -v "$VOLUMES_DIR"/"$SH_DIR"/standalone-logs/:/home/nacos/logs \
  --name "$container_name" \
  "$image"
#  -v "$VOLUMES_DIR"/"$SH_DIR"/conf/:/home/nacos/conf \
