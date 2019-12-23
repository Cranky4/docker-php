FROM php:7.3.13-zts-alpine

RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        cmake \
        file \
        g++ \
        gcc \
        libc-dev \
        pcre-dev \
        make \
        git \
        pkgconf \
        re2c \
        icu-dev \
        libxml2-dev \
        imap-dev \
        openssl-dev \
        imagemagick-dev \
        # for GD
        freetype-dev \
        libpng-dev  \
        libjpeg-turbo-dev \
        libzip-dev \
        zip \
        # git
        openssh bash \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-configure intl --enable-intl \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure mysqli --with-mysqli \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
    && docker-php-ext-configure mbstring --enable-mbstring \
    && docker-php-ext-configure soap --enable-soap \
    && docker-php-ext-configure imap --with-imap-ssl \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) \
        gd \
        bcmath \
        intl \
        pcntl \
        mysqli \
        pdo_mysql \
        mbstring \
        soap \
        iconv \
        imap \
        zip

# Install PECL extensions
RUN	pecl install imagick \
	&& docker-php-ext-enable imagick

#RUN apk del .build-deps \
#    && rm -rf /tmp/* \
#    && rm -rf /app \
#    && mkdir /app

# Iconv Fix, siehe https://github.com/docker-library/php/issues/240#issuecomment-305038173
# Pimcore Issue: https://github.com/pimcore/pimcore/issues/3175
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN php -m
RUN php -v
