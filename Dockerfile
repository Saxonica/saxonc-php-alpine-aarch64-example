FROM php:8.4-alpine

RUN apk add gcompat libstdc++ php84-dev phpunit

RUN mkdir /opt/saxonica
COPY SaxonCHE-linux-arm64-13-0-0.zip /tmp/
COPY docker-php-ext-saxon.ini /usr/local/etc/php/conf.d/
COPY --chmod=755 build-ext.sh /opt/saxonica

WORKDIR /opt/saxonica
RUN unzip /tmp/SaxonCHE-linux-arm64-13-0-0.zip && rm /tmp/SaxonCHE-linux-arm64-13-0-0.zip
RUN cp -r /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/SaxonCCoreHE/lib/* /usr/local/lib/
RUN cp -r /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/SaxonCCoreHE/include/* /usr/local/include/
RUN cp -r /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/SaxonCHE/lib/* /usr/local/lib/
RUN cp -r /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/SaxonCHE/bin/* /usr/local/bin/
RUN cp -r /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/SaxonCHE/include/* /usr/local/include/

WORKDIR /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/php/src
RUN apk add --no-cache --virtual .phpize-deps-configure patch gdb $PHPIZE_DEPS
COPY php_config.patch /opt/saxonica/php_config.patch
RUN patch -p3 < /opt/saxonica/php_config.patch
RUN /opt/saxonica/build-ext.sh /opt/saxonica/SaxonCHE-linux-arm64-13-0-0/php/src

ENV LD_PRELOAD=/lib/libgcompat.so.0
CMD ["phpunit", "/opt/saxonica/SaxonCHE-linux-arm64-13-0-0/php/samples/SaxonCPHPTests.php"]