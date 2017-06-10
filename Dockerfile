FROM alpine:3.4

MAINTAINER Ryan Boyle <ryan@boyle.io>

RUN apk --update add sudo                                         && \
    echo "===> Adding Python runtime..."  && \
    apk --update add python py-pip openssl ca-certificates git bash  && \
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
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


ONBUILD  RUN  echo "===> Updating TLS certificates..."         && \
              apk --update add openssl ca-certificates


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
