FROM ubuntu:10.04
MAINTAINER IgorSh

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r -g 1000 builduser && useradd -r -g builduser -u 1000 builduser

RUN echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu lucid main" > /etc/apt/sources.list.d/git-core-ppa-lucid.list \
    && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu lucid main" > /etc/apt/sources.list.d/webupd8team-java-lucid.list \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A1715D88E1DF1F24 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 \
    && apt-get update \
    && apt-get upgrade -y        
RUN apt-get install -y \
		git \   
        ia32-libs \     
		gnupg \
		flex \
		bison \
		gperf \
		build-essential \
		zip \
		curl \
		libc6-dev \
		x11proto-core-dev \
		g++-multilib \
		mingw32 \
		tofrodos \
		libgl1-mesa-dev \
		python-markdown \
		libxml2-utils \
		xsltproc \
        zlib1g-dev \
        libncurses5-dev \
        libx11-dev \
        libreadline6-dev \
        libgl1-mesa-glx \
        oracle-java6-set-default \
	&& rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

RUN mkdir -p /build \
	&& chown -R builduser:builduser /build

WORKDIR /build

VOLUME /build

COPY docker-entrypoint.sh /entrypoint.sh
RUN chown -R builduser:builduser /entrypoint.sh && chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

#USER builduser
CMD ["./mk"]
