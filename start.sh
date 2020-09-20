#!/bin/bash
envsubst < /icecast.xml.tpl > /etc/icecast2/icecast.xml
#/usr/bin/icecast2 -c /etc/icecast2/icecast.xml
sudo -Eu icecast2 icecast2 -c /etc/icecast2/icecast.xml
