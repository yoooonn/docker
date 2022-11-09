#!/usr/bin/env bash

find ./nacos/conf -name "*.properties" -print0 | xargs perl -pi.bak -e "s/# spring.datasource.platform=mysql/spring.datasource.platform=mysql/gi"
find ./nacos/conf -name "*.properties" -print0 | xargs perl -pi.bak -e "s/# db.num=1/db.num=1/gi"
find ./nacos/conf -name "*.properties" -print0 | xargs perl -pi.bak -e "s/# db.url.0=jdbc:mysql:\/\/127.0.0.1:3306\/nacos/db.url.0=jdbc:mysql:\/\/mysql8:3307\/nacos_devtest/gi"
find ./nacos/conf -name "*.properties" -print0 | xargs perl -pi.bak -e "s/# db.user.0=nacos/db.user.0=root/gi"
find ./nacos/conf -name "*.properties" -print0 | xargs perl -pi.bak -e "s/# db.password.0=nacos/db.password.0=root/gi"

cat ./nacos/conf/application.properties
