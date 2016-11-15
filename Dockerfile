FROM alpine:3.4
MAINTAINER Manuel Andres Garcia Vazquez "<mvazquez@scabb-island.com.ar"

# Build-time metadata as defined at http://label-schema.org
  ARG BUILD_DATE
  ARG VCS_REF
  ARG VERSION
  LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Docker SNMP Proxy" \
        org.label-schema.description="SNMP Proxy for docker-compose environment." \
        org.label-schema.url="https://github.com/mgvazquez/docker-snmp-proxy" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/mgvazquez/docker-snmp-proxy" \
        org.label-schema.vendor="scabb-island" \
        org.label-schema.version=$VERSION

ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV NET_SNMP_VERSION=5.7.3-r5
ENV SUPERVISOR_VERSION=3.3.0
ENV DOCKER_GEN_VERSION=0.7.3
ENV DOCKER_HOST=unix:///tmp/docker.sock

EXPOSE 161/udp
WORKDIR /tmp

ADD extras /etc/

# ---- https://github.com/jwilder/docker-gen ----
ADD https://github.com/jwilder/docker-gen/releases/download/${DOCKER_GEN_VERSION}/docker-gen-alpine-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz /tmp/docker-gen-alpine.tgz
# -----------------------------------------------

RUN echo -e "http://dl-4.alpinelinux.org/alpine/latest-stable/main\n@testing http://dl-4.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories &&\
    apk add --update \
      net-snmp=${NET_SNMP_VERSION} \
      python=${PYTHON_VERSION} \
      py-pip=${PY_PIP_VERSION} &&\
    rm -rf /var/cache/apk/*

RUN pip install supervisor==${SUPERVISOR_VERSION}

RUN tar -C /usr/local/bin -zxvf /tmp/docker-gen-alpine.tgz &&\
    chown root.root /usr/local/bin/docker-gen &&\
    mv /etc/entrypoint.sh /usr/local/bin/ &&\
    chmod a+x /usr/local/bin/entrypoint.sh &&\
    rm -rf /tmp/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
