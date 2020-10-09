FROM php:5.6.7-apache
RUN mkdir /a2billing-extra
RUN mkdir /usr/local/src/a2billing
COPY [ "a2billing/","/usr/local/src/a2billing/" ]
COPY [ "script-dockerfile-apache.sh","/" ]
RUN apt-get update -y && \
#    apt-get upgrade -y && \
    apt-get install -y php5-common php5-cli php5-mysql php5-gd php5-mcrypt && \
    apt-get install -y subversion asterisk
#libapache2-mod-php5 php5
RUN bash /script-dockerfile-apache.sh
#CMD [ "mysqld" ]
