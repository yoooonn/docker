#!/usr/bin/env bash

set -eu
# shellcheck source=/dev/null
source ./globals

image=mongo:4.2-rc

# ROOT_DIR
# VOLUMES_DIR

docker run --rm -d -p 27017:27017 \
        --name mongo \
        "$image"
