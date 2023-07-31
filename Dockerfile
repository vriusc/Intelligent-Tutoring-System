FROM mysql:8.0.33
//RUN git clone https://github.com/vriusc/Intelligent-Tutoring-System.git
//RUN cd Intelligent-Tutoring-System && git checkout Database-Dev
ENV MYSQL_ROOT_PASSWORD="Souvenir"
ENV MYSQL_DATABASE="test"
COPY mysql.cnf /etc/mysql/conf.d/

ADD test.sql docker-entrypoint-initdb.d/db_backup.sql
