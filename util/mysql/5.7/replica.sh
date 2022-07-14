#!/usr/bin/env bash

set -eu
. ./globals

#WORK_DIR
#VOLUMES_DIR

docker network create mysql-cluster > /dev/null || echo 'Network 'mysql-cluster' already exist. Skip create it.'

docker run --rm -d -p 13306:3306 \
        --name mmysql \
        --network mysql-cluster \
        --network-alias mmysql \
        -e 'MYSQL_ROOT_PASSWORD=root'\
        -v "$VOLUMES_DIR"/"$DIR"/data/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$DIR"/data/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$DIR"/log:/var/log/mysql \
        mysql:5.7


docker run --rm -d -p 13307:3306 \
        --name smysql \
        --network mysql-cluster \
        --network-alias smysql \
        -e 'MYSQL_ROOT_PASSWORD=root'\
        -v "$VOLUMES_DIR"/"$DIR"/sdata/db:/var/lib/mysql \
        -v "$VOLUMES_DIR"/"$DIR"/sdata/conf:/etc/mysql/conf.d \
        -v "$VOLUMES_DIR"/"$DIR"/slog:/var/log/mysql \
        mysql:5.7 \
        mysqld --skip-slave-start --character-set-server=utf8 --collation-server=utf8_unicode_ci