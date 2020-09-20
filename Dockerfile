FROM ubuntu:bionic
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV SOURCE_PASSWORD=secret123
ENV RELAY_PASSWORD=secret123
ENV ADMIN_PASSWORD=secret123
ENV TARGET_HOSTNAME=0.0.0.0

ENV DEBIAN_FRONTEND noninteractive
#APT
RUN \
  apt-get -yqq update \
  && apt-get install -yqq sudo gettext icecast2 \
  && rm -Rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND interactive

CMD ["/start.sh"]
EXPOSE 8000
VOLUME /var/log/icecast2

COPY start.sh /start.sh
COPY icecast.xml.tpl /icecast.xml.tpl
