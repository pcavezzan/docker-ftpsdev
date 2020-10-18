# FTPS for development

It's just a small container image to set up for local development a FTPS server based on [ProFTPD](http://www.proftpd.org/) 
project.

It allows to create FTP with TLS enabled with a self signed certificate with default user (user/password).

## Run

```shell
docker container run --rm --name ftpsdev pcavezzan/ftpsdev:latest
```

or create the following docker-compose.yaml:
```yaml
version: '3'

services:
  ftps:
    image: pcavezzan/ftpsdev:latest
    ports:
    - "21:21"
    - "50000-50050:50000-50050" 
```

then:
```shell
docker-compose up
```

You will be able to connect to localhost:21 with default user:
* username: username
* password: password


## Customization 

You can use a custom user/password and certificate by passing environment variable:

|      Name                     |     Default Value      |
|:-----------------------------:|:----------------------:|
| FTP_USER                      |          user          |
| FTP_PWD                       |        password        |
| FTP_PASSIVE_PORT_MIN          |        50000           |
| FTP_PASSIVE_PORT_MAX          |        50009           |
| FTP_PWD                       |        password        |
| TLS_CN                        |          app           |
| TLS_ORG                       |       organization     |
| TLS_C                         |           fr           |

## Build

```shell
git clone https://github.com/pcavezzan/docker-ftpsdev.git
cd docker-ftpsdev
docker image build -t xxxx/ftpsdev .
```

## Why this image

I used to use the amazing image [stilliard/pure-ftpd](https://hub.docker.com/r/stilliard/pure-ftpd) to get an FTP server 
for local development. Unfortunatly, lately, I faced a problem while I needed an FTPS with `stilliard/pure-ftpd` image with TLS.
It was not an image problem but more a [PureFTPd](https://www.pureftpd.org/project/pure-ftpd/) with [FTPSClient](https://commons.apache.org/proper/commons-net/javadocs/api-3.6/org/apache/commons/net/ftp/FTPSClient.html) Java Client:
* https://issues.apache.org/jira/browse/NET-598
* http://camel.465427.n5.nabble.com/FTPS-Handshake-error-td5829967.html
* http://mail-archives.apache.org/mod_mbox/commons-issues/201902.mbox/%3CJIRA.13216659.1550586982000.8215.1551338160057@Atlassian.JIRA%3E

## Useful resources and thanks

To make this container image, I got inspired by the following resources:
* https://github.com/stilliard/docker-pure-ftpd/
* https://git.asperti.com/paspo/docker-ftps
* https://angristan.fr/generer-certificat-auto-signe-rsa-4096-bits-sha-2-512-bits/
 