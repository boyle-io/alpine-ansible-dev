FROM alpine:3.5

MAINTAINER Ryan Boyle <ryan@boyle.io>

RUN apk add --no-cache --virtual .remove-deps \
    build-base \
    gcc \
    abuild \
    binutils \
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
    rm -rf /var/cache/apk/*               && \

ONBUILD  RUN  echo "===> Updating TLS certificates..."         && \
              apk --update add openssl ca-certificates


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
