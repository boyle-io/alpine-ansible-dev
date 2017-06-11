FROM alpine:3.5

MAINTAINER Ryan Boyle <ryan@boyle.io>

RUN apk add --no-cache --virtual .remove-deps \
    build-base \
    gcc \
	libc-dev \
	make \
	openssl-dev \
	pcre-dev \
	zlib-dev \
	linux-headers \
	curl \
	gnupg \
	libxslt-dev \
	gd-dev \
	geoip-dev \
    python \
    py-pip \
    openssl \
    openssl-dev \
    ca-certificates \
    git \
    bash \
    zip \
    gcc \
    python-dev \
    libffi-dev && \
    pip install --upgrade pip cffi  && \
    mkdir -p /soa/apps && \
    cd /soa/apps && \
    git clone https://github.com/ansible/ansible.git --recursive  && \
    cd /soa/apps/ansible && \
    pip install -r ./requirements.txt && \
    echo ". /soa/apps/ansible/hacking/env-setup -q" >> ~/.bashrc && \
    

    echo "===> Removing package list..."  && \
    #apk del build-dependencies            && \
    rm -rf /var/cache/apk/*
