FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

CMD ["/usr/local/bin/setup.sh"]