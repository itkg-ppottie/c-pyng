FROM php:7.1-fpm-alpine

LABEL maintenainer="Pierre Pottié <pierre.pottie@gmail.com>"


ENV PATH /root/.yarn/bin:$PATH

RUN apk add --no-cache nodejs-npm yarn
RUN  rm -rf  /usr/share/man /tmp/* /var/cache/apk/* \
    /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
/usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer --version

RUN yarn global add gulp --prefix /usr/local

WORKDIR  /var/www

CMD ["gulp","watch"]