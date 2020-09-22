#!/bin/bash
PASS_LENGTH=12
this_rand()
{
  RANDOM_PASS=$(uuidgen -r | sha512sum | base64 | head -c ${PASS_LENGTH})
}

# If any of these variable equals 'random' then reset to random
if [ "$SOURCE_PASSWORD" = 'random' ]; then
  this_rand
  export SOURCE_PASSWORD=$RANDOM_PASS
  echo "your SOURCE_PASSWORD is set to '$RANDOM_PASS'"
else
  echo "SOURCE_PASSWORD=$SOURCE_PASSWORD"
fi
if [ "$RELAY_PASSWORD" = 'random' ]; then
  this_rand
  export RELAY_PASSWORD=$RANDOM_PASS
  echo "your RELAY_PASSWORD is set to '$RANDOM_PASS'"
fi
if [ "$TARGET_ADMIN_USER" = 'random' ]; then
  this_rand
  export TARGET_ADMIN_USER=$RANDOM_PASS
  echo "your ADMIN_USER is set to '$RANDOM_PASS'"
fi
if [ "$ADMIN_PASSWORD" = 'random' ]; then
  this_rand
  export ADMIN_PASSWORD=$RANDOM_PASS
  echo "your ADMIN_PASSWORD is set to '$RANDOM_PASS'"
fi

if [ "$RELAY_MODE" = 'all' ]; then
  echo 'All mode enabled'
  export RANDOM_ICE=$((1 + RANDOM % 6 ))
  echo RANDOM_ICE $RANDOM_ICE
  envsubst < /home/icecast2/icecast.all.xml.tpl > /home/icecast2/icecast.xml
else
  envsubst < /home/icecast2/icecast.xml.tpl > /home/icecast2/icecast.xml
fi

main () {
  if [ -x "/usr/bin/icecast2" ]; then
    THIS_ICECAST=/usr/bin/icecast2
  elif [ -x "/usr/bin/icecast" ]; then
    THIS_ICECAST=/usr/bin/icecast
  fi
  $THIS_ICECAST -c /home/icecast2/icecast.xml
}


main $@
