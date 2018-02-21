FROM php:7.1-fpm

LABEL maintenainer="Pierre Pottié <pierre.pottie@gmail.com>"

RUN systemMods=" \
        apt-transport-https \
        git \
        gnupg \
        unzip  \
    " \
    && apt-get update \
    && apt-get install -y $systemMods \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install Composer
COPY --from=composer:1.5 /usr/bin/composer /usr/bin/composer
RUN composer --version

RUN yarn global add gulp --prefix /usr/local

RUN npm install --save-dev gulp-cdnizer gulp-yarn gulp-inject
RUN yarn add gulp-yarn -D

WORKDIR  /var/www

CMD ["gulp","watch"]