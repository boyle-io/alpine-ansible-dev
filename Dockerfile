FROM alpine:3.5

MAINTAINER Ryan Boyle <ryan@boyle.io>

    # add dependencies to be removed by packer
RUN apk --update add --virtual ansible-dependencies\
    python \
    py-pip \
    openssl \
    bash \
    ca-certificates && \
    # add dependencies to be removed
    apk --update add --virtual build-dependencies \
    python-dev \
    libffi-dev \
    openssl-dev \
    git \
    build-base  && \

    # change shell to bash or ansible will fail from packer
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \

    pip install --upgrade pip cffi  && \

    # create dir for ansible.  Will be removed by packer. 
    mkdir -p /opt && \

    cd /opt && \

    git clone https://github.com/ansible/ansible.git --recursive  && \

    cd /opt/ansible && \

    pip install -r ./requirements.txt && \

    # source ansible
    echo ". /opt/ansible/hacking/env-setup -q" >> ~/.bashrc && \
    
    #cleanup
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*
