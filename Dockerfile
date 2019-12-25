FROM lsiobase/nginx:3.11

# set version label
ARG BUILD_DATE
ARG VERSION
ARG TT_RSS_VERSION
LABEL build_version="master ${BUILD_DATE}"
LABEL maintainer="lunik1"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --upgrade \
	curl \
	git \
	grep \
	php7-apcu \
	php7-curl \
	php7-dom \
	php7-gd \
	php7-iconv \
	php7-intl \
	php7-ldap \
	php7-mcrypt \
	php7-mysqli \
	php7-mysqlnd \
	php7-pcntl \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pgsql \
	php7-posix \
	tar && \
 echo "**** install software ****" && \
 mkdir -p \
	/var/www/html/ && \
 if [ -z ${TT_RSS_VERSION+x} ]; then \
 	TT_RSS_VERSION=master; \
 fi && \
 curl -o \
	/tmp/ttrss.tar.gz -L \
	"https://gitlab.com/lunik1/tt-rss/-/archive/master/tt-rss-${TT_RSS_VERSION}.tar.gz" && \
 tar xf \
 /tmp/ttrss.tar.gz -C \
	/var/www/html/ --strip-components=1 && \
 echo "**** link php7 to php ****" && \
 ln -sf /usr/bin/php7 /usr/bin/php && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
