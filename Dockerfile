FROM registry.redhat.io/devspaces/udi-rhel8@sha256:d55549aad15742f6f7310da0c7abc1e65dd5d3ad2e3efb8fbf414cf91b9efac7
USER root
ENV ANSIBLE_VERSION="2.9.27"

RUN INSTALL_PKGS="python39 python39-devel python39-setuptools python39-pip" &&\
    yum -y module enable python39:3.9 && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum -y clean all --enablerepo='*'

RUN python3.9 -m pip install --upgrade pip &&\
    python3.9 -m pip install --no-cache-dir virtualenv

RUN pip3 install "ansible==${ANSIBLE_VERSION}" \
    virtualenv \
    ansible-lint==5.4.0 \
    molecule \
    yamllint \
    pyOpenSSL \
    pyvmomi \
    netaddr \
    xmltodict \
    ansible-review \
    jmespath \
    Jinja2 \
    jq
