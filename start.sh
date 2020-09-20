#!/bin/bash
PASS_LENGTH=12
this_rand()
{
  local DATE3=$(date +"%N-%S" | sha256sum)
  local SEED1=$(uuidgen -r)
  local SEED2=$(echo $SEED1:$DATE3 | sha512sum)
  local myresult=$(echo $SEED2 | sha512sum | base64 | head -c ${PASS_LENGTH})
  RANDOM_PASS=$myresult
}

if [[ "$SOURCE_PASSWORD" == 'random' ]]; then
  this_rand
  export SOURCE_PASSWORD=$RANDOM_PASS
  echo "your SOURCE_PASSWORD is set to '$RANDOM_PASS'"
else
  echo "SOURCE_PASSWORD=$SOURCE_PASSWORD"
fi
if [[ "$RELAY_PASSWORD" == 'random' ]]; then
  this_rand
  export RELAY_PASSWORD=$RANDOM_PASS
  echo "your RELAY_PASSWORD is set to '$RANDOM_PASS'"
fi
if [[ "$ADMIN_PASSWORD" == 'random' ]]; then
  this_rand
  export ADMIN_PASSWORD=$RANDOM_PASS
  echo "your ADMIN_PASSWORD is set to '$RANDOM_PASS'"
fi

envsubst < /icecast.xml.tpl > /etc/icecast2/icecast.xml
#/usr/bin/icecast2 -c /etc/icecast2/icecast.xml
sudo -Eu icecast2 icecast2 -c /etc/icecast2/icecast.xml
