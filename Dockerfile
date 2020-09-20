FROM ubuntu:bionic
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV SOURCE_PASSWORD=random
ENV RELAY_PASSWORD=random
ENV ADMIN_PASSWORD=random
ENV TARGET_HOSTNAME=0.0.0.0
ENV TARGET_LOCATION=DroneStarState
ENV TARGET_ADMIN_EMAIL='nalocal512@your.local.na.chapter.org'
ENV TARGET_ADMIN_USER=NAlocal512

ENV DEBIAN_FRONTEND noninteractive
#APT
RUN \
  apt-get -yqq update \
  && apt-get install -yqq mime-support uuid-runtime gettext icecast2 \
  && rm -Rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND interactive



RUN mkdir -p /home/icecast2
COPY start.sh /home/icecast2/start.sh
COPY icecast.xml.tpl /home/icecast2/icecast.xml.tpl
RUN chown -R icecast2 /home/icecast2
USER icecast2
WORKDIR /home/icecast2
CMD ["/home/icecast2/start.sh"]
EXPOSE 8000
VOLUME /var/log/icecast2
