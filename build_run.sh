#!/usr/bin/env bash

docker build -t docker-nginx-v2ray .

cert_dir=$(pwd)/cert
SITE_DOMAIN="domain"
echo "cert_dir"
echo $cert_dir
mkdir -p ${cert_dir}
docker container run \
    -d \
    --name nginx-v2ray \
    -p 80:80 \
    -p 443:443 \
    -v "/etc/letsencrypt/archive/$(SITE_DOMAIN)":/data/cert/$(SITE_DOMAIN) \
    -e SITE_DOMAIN="$(SITE_DOMAIN)" \
    -e V2RAY_TOKEN="0000000-0000-0000-000-000000" \
    -e V2RAY_PORT=12345
    -e SSL_PORT=443
    -e V2RAY_WS_PATH=/ray \
    docker-nginx-v2ray