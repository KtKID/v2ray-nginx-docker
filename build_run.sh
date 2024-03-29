#!/usr/bin/env bash
    # -e V2RAY_TOKEN="0000000-0000-0000-000-000000" \
container_name="nginx-v2ray"
if [ "$(docker ps -q -f name=${container_name})" ];
then
    echo "${container_name} exist and will restart in 5s"
    [ "$(docker restart -t 5 ${container_name})" ]
else
    echo "${container_name} not exist"

    docker build -t docker-nginx-v2ray .

    SITE_DOMAIN="domain" #你的域名
    SSL_PORT_START=10000    #start-end受限于nginx最大连接数量
    SSL_PORT_END=10010
    V2RAY_PORT=54321
    TOKEN="0000000-0000-0000-000-000000"
    WS_PATH="/xxx"

    port_flags=""
    for((i=$SSL_PORT_START; i<$SSL_PORT_END; i++))
    do
        port_flags+="-p $i:$i "
    done
    echo "ssl port is $port_flags"

    docker container run \
        -d \
        --name nginx-v2ray \
        $port_flags \
        -p ${V2RAY_PORT}:${V2RAY_PORT} \
        -v "/etc/letsencrypt/archive/${SITE_DOMAIN}":/data/cert/${SITE_DOMAIN} \
        -e SITE_DOMAIN="${SITE_DOMAIN}" \
        -e V2RAY_TOKEN=${TOKEN} \
        -e V2RAY_PORT=${V2RAY_PORT} \
        -e SSL_PORT_START=${SSL_PORT_START} \
        -e SSL_PORT_END=${SSL_PORT_END} \
        -e V2RAY_WS_PATH=${WS_PATH} \
        docker-nginx-v2ray
fi