#!/usr/bin/env bash
    # -e V2RAY_TOKEN="0000000-0000-0000-000-000000" \
docker build -t docker-nginx-v2ray .

SITE_DOMAIN="domain" #你的域名
SSL_PORT=13431
V2RAY_PORT=54321
docker container run \
    -d \
    --name nginx-v2ray \
    -p 80:80 \
    -p ${V2RAY_PORT}:${V2RAY_PORT} \
    -p ${SSL_PORT}:${SSL_PORT} \
    -v "/etc/letsencrypt/archive/${SITE_DOMAIN}":/data/cert/${SITE_DOMAIN} \
    -e SITE_DOMAIN="${SITE_DOMAIN}" \
    -e V2RAY_TOKEN="0000000-0000-0000-000-000000" \
    -e V2RAY_PORT=${V2RAY_PORT} \
    -e SSL_PORT=${SSL_PORT} \
    -e V2RAY_WS_PATH=/ray \
    docker-nginx-v2ray