FROM ubuntu:10.04
MAINTAINER IgorSh
RUN echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu lucid main" > /etc/apt/sources.list.d/git-core-ppa-lucid.list \
    && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu lucid main" > /etc/apt/sources.list.d/webupd8team-java-lucid.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A1715D88E1DF1F24 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 \
    && apt-get update \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
	&& apt-get install -y \
        oracle-java6-set-default \
		git \
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
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /build
WORKDIR /build

VOLUME /build

CMD ["./mk","check-env"]
