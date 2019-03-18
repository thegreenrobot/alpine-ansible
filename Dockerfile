# pull base image
FROM alpine:3.8

MAINTAINER Matthew Green <thematthewgreen@gmail.com>


RUN echo "===> Install sudo ..."  && \
    apk --update add sudo                                         && \
    \
    \
    echo "===> Install Python runtime..."  && \
    apk --update add bash git python py-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi                            && \
    \
    \
    echo "===> Install Ansible..."  && \
    pip install ansible==2.7.8               && \
    pip install ansible-lint==4.1.0               && \
    \
    \
    echo "===> Install other handy tools (not absolutely required)..."  && \
    pip install --upgrade pycrypto pywinrm         && \
    apk --update add sshpass openssh-client rsync  && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
