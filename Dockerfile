# FROM nginx:latest
FROM v2fly/v2fly-core:latest
# RUN yum update -y
RUN apk add --no-cache nginx bash \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /xgt

COPY conf /conf
COPY html /data/www/html

COPY run.sh /run.sh
RUN chmod 744 /run.sh

EXPOSE 443
ENTRYPOINT "/run.sh"