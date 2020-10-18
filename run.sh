#!/bin/sh

FTP_USER=${FTP_USER:-user}
FTP_PWD=${FTP_PWD:-password}

if [ ! -f /auth/passwd ];then
  mkdir -p /srv/ftp/$FTP_USER && chown 1000:1000 /srv/ftp/$FTP_USER
  echo $FTP_PWD | ftpasswd --stdin --passwd --name=$FTP_USER --uid=1000 --gid=1000 --home=/srv/ftp/$FTP_USER --shell=/bin/false
  mv ftpd.passwd /etc/proftpd/ftpd.passwd
  chmod 0600 /etc/proftpd/ftpd.passwd
fi

TLS_CN=${TLS_CN:-app}
TLS_ORG=${TLS_ORG:-organization}
TLS_C=${TLS_C:-fr}

if [ ! -e /etc/proftpd/cert.pem ];then
  openssl genrsa -out /etc/proftpd/key.pem 4096
  openssl req -subj "/CN=${TLS_CN}/O=${TLS_ORG}/C=${TLS_C}" -days 3650 \
        -x509 -nodes \
        -key /etc/proftpd/key.pem \
        -out /etc/proftpd/cert.pem
fi

FTP_PASSIVE_PORT_MIN=${FTP_PASSIVE_PORT_MIN:-50000}
FTP_PASSIVE_PORT_MAX=${FTP_PASSIVE_PORT_MAX:-50009}
echo "PassivePorts ${FTP_PASSIVE_PORT_MIN} ${FTP_PASSIVE_PORT_MAX}" > /etc/proftpd/conf.d/passive_ports.conf

exec proftpd --nodaemon
