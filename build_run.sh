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

    SITE_DOMAIN="kingkid.fun" #你的域名
    SSL_PORT_START=50000    #start-end受限于nginx最大连接数量
    SSL_PORT_END=50010
    V2RAY_PORT=54321

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
        -e V2RAY_TOKEN="981e3a35-ee2c-4b78-874b-ec8acf87edc2" \
        -e V2RAY_PORT=${V2RAY_PORT} \
        -e SSL_PORT_START=${SSL_PORT_START} \
        -e SSL_PORT_END=${SSL_PORT_END} \
        -e V2RAY_WS_PATH=/xxx \
        docker-nginx-v2ray
fi