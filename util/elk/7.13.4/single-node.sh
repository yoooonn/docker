#!/usr/bin/env bash
# author: yooonn

set -eu

# shellcheck source=/dev/null
source ./globals

image=docker.elastic.co/elasticsearch/elasticsearch:7.13.4-arm64
kibana_image=docker.elastic.co/kibana/kibana:7.13.4-arm64

#WORK_DIR
#VOLUMES_DIR

#docker ps -a | grep "es01" >/dev/null 2>&1 && docker restart es01
#docker ps -a | grep "ki01" >/dev/null 2>&1 && docker restart ki01 && exit 0

docker run -d -p 9200:9200 -p 9300:9300 \
  --name es01 --restart=unless-stopped \
  --network elastic \
  --network-alias es01 \
  -v "$VOLUMES_DIR"/"$DIR"/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
  -e "discovery.type=single-node" \
  "$image"

docker run -d -p 5601:5601 \
  --name ki01 --restart=unless-stopped \
  --network elastic \
  -v "$VOLUMES_DIR"/"$DIR"/kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml \
  -e "ELASTICSEARCH_HOSTS=http://es01:9200" \
  "$kibana_image"
