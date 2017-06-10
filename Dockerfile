FROM alpine:3.4

MAINTAINER Ryan Boyle <ryan@boyle.io>

RUN apk --update add python py-pip openssl ca-certificates git bash  && \
    apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi  && \
    mkdir -p /soa/apps && \
    cd /soa/apps && \
    git clone https://github.com/ansible/ansible.git --recursive  && \
    cd /soa/apps/ansible && \
    pip install -r ./requirements.txt && \
    echo ". /soa/apps/ansible/hacking/env-setup -q" >> ~/.bashrc && \
    

    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \


ONBUILD  RUN  echo "===> Updating TLS certificates..."         && \
              apk --update add openssl ca-certificates
