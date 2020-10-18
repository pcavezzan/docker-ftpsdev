FROM alpine:edge

LABEL maintainer="pcavezzan@gmail.com"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk -U add proftpd proftpd-mod_tls proftpd-mod_ifsession proftpd-utils openssl perl \
    && mkdir -p /var/run/proftpd

COPY custom.conf /etc/proftpd/conf.d/custom.conf
COPY run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 21 50000-50009

ENTRYPOINT ["/run.sh"]
