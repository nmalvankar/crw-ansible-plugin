FROM registry.redhat.io/codeready-workspaces/plugin-java11-rhel8@sha256:79b59596870382e968850bc241ac41a3345a9079f28251808e35479f92bd3b86
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

USER jboss
ENTRYPOINT ["/home/jboss/entrypoint.sh"]
WORKDIR /projects
