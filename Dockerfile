FROM alpine:3.4
MAINTAINER Manuel Andres Garcia Vazquez "<mvazquez@scabb-island.com.ar"

ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
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
      net-snmp \
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
