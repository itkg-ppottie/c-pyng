FROM php:fpm7.2-alpine

LABEL maintenainer="Pierre Pottié <pierre.pottie@gmail.com>"



RUN systemMods=" \
        apt-transport-https \
        git \
        gnupg \
        unzip  \
        yarn \
    " \
    && apt-get update \
    && apt-get install -y $systemMods \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer --version

RUN yarn global add gulp --prefix /usr/local

WORKDIR  /var/www

CMD ["gulp","watch"]