FROM mysql:8.0.27

EXPOSE 3306

ENV MYSQL_ROOT_PASSWORD=password

COPY myschema.sql /docker-entypoint-initdb.d