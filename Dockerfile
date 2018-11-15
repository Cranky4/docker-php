FROM php:7.2.12-zts-alpine

RUN docker-php-ext-configure intl \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
       iconv \
       mcrypt \
       intl \
       pdo \
       pdo_mysql \
       mbstring \
       opcache \
       zip \
       exif \
       bz2 \
       imap
