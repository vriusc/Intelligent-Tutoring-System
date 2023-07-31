FROM mysql:8.0.33

ENV MYSQL_ROOT_PASSWORD="Souvenir"
ENV MYSQL_DATABASE="test"
COPY mysql.cnf /etc/mysql/conf.d/

ADD test.sql docker-entrypoint-initdb.d/db_backup.sql
