# noagendastream-mirror
Mirror for the No Agenda Stream


## Pull

```
  docker pull nalocal512/noagendastream-mirror
```

## Run

You can set the passwords like so:

```
  docker run \
    -d \
    -p 8000:8000 \
    --cidfile .cid \
    --name noagendastream-mirror \
    -e  noagendastream-mirror \
    -e SOURCE_PASSWORD=testing123 \
    -e RELAY_PASSWORD=testing123 \
    -e ADMIN_PASSWORD=testing123 \
    -e TARGET_HOSTNAME=localhost \
    -e TARGET_LOCATION=Earth \
    -e TARGET_ADMIN_EMAIL='testmaster@localhost' \
    -e TARGET_ADMIN_USER=funkyadmin \
    -v logs:/var/log/icecast2 \
    -t nalocal512/noagendastream-mirror
```

In this case you can now access your 'mirror' by going to 
[http://localhost:8000/mirror](http://localhost:8000/mirror)
and the username would `funkyadmin` and the password would be `testing123`.  Adjust those values accordingly in your `docker run` command, most importantly would be `TARGET_HOSTNAME` which you should set to a local domain name or IP address so that external computers around your LAN can access the relay.

## Build

You can build locally:

```
  docker build -t nalocal512/noagendastream-mirror .
```
