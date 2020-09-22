FROM ubuntu:bionic
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV RELAY_MODE=normal \
    SOURCE_PASSWORD=random \
    RELAY_PASSWORD=random \
    ADMIN_PASSWORD=random \ 
    TARGET_HOSTNAME=0.0.0.0 \
    TARGET_LOCATION=DroneStarState \
    TARGET_ADMIN_EMAIL='nalocal512@your.local.na.chapter.org' \
    TARGET_ADMIN_USER=NAlocal512

ENV DEBIAN_FRONTEND noninteractive
#APT
RUN \
  apt-get -yqq update \
  && apt-get install -yqq mime-support uuid-runtime gettext icecast2 \
  && rm -Rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND interactive

RUN mkdir -p /home/icecast2
COPY util.bash /home/icecast2/util.bash
COPY start.bash /home/icecast2/start.bash
COPY icecast.xml.tpl /home/icecast2/icecast.xml.tpl
COPY icecast.all.xml.tpl /home/icecast2/icecast.all.xml.tpl
RUN chown -R icecast2 /home/icecast2
USER icecast2
WORKDIR /home/icecast2
CMD ["/home/icecast2/start.bash"]
EXPOSE 8000
VOLUME /var/log/icecast2
