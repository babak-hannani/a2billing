FROM mysql:5.7
RUN mkdir /a2billing-mysql-5.x
#WORKDIR /
ENV MYSQL_ROOT_PASSWORD: "a2billing"
ENV MYSQL_DATABASE: "mya2billing"
ENV MYSQL_USER: "a2billinguser"
ENV MYSQL_PASSWORD: "a2billing"
#COPY [ "mysql-5.x/a2billing-createdb-user.sql","/docker-entrypoint-initdb.d/" ]
#COPY [ "mysql-5.x/","/docker-entrypoint-initdb.d/" ]
COPY [ "mysql-5.x/","/a2billing-mysql-5.x/" ]
COPY [ "mysql-5.x/install-db.sh","/docker-entrypoint-initdb.d/" ]
#COPY [ "mysql-5.x/a2billing-createdb-user.sql/UPDATE*sql","/docker-entrypoint-initdb.d" ]
#COPY [ "script-dockerfile-mysql.sh","/" ]
#RUN bash /script-dockerfile-mysql.sh
#ENTRYPOINT [ "script-dockerfile-mysql.sh" ]
#CMD [ "mysqld" ]
