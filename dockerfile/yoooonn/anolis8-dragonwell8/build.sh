#!/usr/bin/env bash
# author yooonn

source ./globals

docker build -f "$(get_script_path)"/Dockerfile -t yoooonn/anolis8-dragonwell8:0.1 .
