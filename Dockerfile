FROM php:7.2.12-zts-alpine

RUN wget http://security.ubuntu.com/ubuntu/pool/main/a/apt/apt_1.4_amd64.deb
RUN apt-get install sudo

# Install tools...
RUN sudo apt-get install -y zlib1g-dev libicu-dev libjpeg-dev libmcrypt-dev libbz2-dev

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
