FROM php:8.0-apache AS php
WORKDIR /var/www/html
ADD https://github.com/nooruzaman/CSE3SOX_A2/raw/main/Web_Application_Original.zip tmp.zip

RUN apt-get -y update \
  && apt-get -y install unzip \
  && docker-php-ext-install mysqli \
  && unzip -j tmp.zip "Web_Application_Original/*" -d . \
  && rm -rf tmp.zip \
  && sed -i 's/localhost/db/g' *.php

FROM mariadb AS db

ADD https://raw.githubusercontent.com/nooruzaman/CSE3SOX_A2/main/user_accounts.sql \
  /docker-entrypoint-initdb.d/dump.sql

RUN chmod 777 /docker-entrypoint-initdb.d/dump.sql
