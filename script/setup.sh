#!/usr/bin/env bash

mkdir -p tmp/cache
chmod 777 -R tmp
mkdir -p log
chmod 777 log

# dockerイメージ取得
docker-compose build
