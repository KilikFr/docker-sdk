FROM mysql/mysql-server:5.7

MAINTAINER Michel NAUD <michel.naud@sfam.eu>

RUN mkdir -p /var/log/mysql
RUN chown mysql:mysql /var/log/mysql
COPY my.cnf /etc/my.cnf
COPY init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306
