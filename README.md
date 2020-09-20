# noagendastream-mirror

Icecast2 Mirror for the No Agenda Stream

## TLDR

```
docker pull nalocal512/noagendastream-mirror
docker run -d -P --cidfile na.cid nalocal512/noagendastream-mirror
```

Your username will be `NAlocal512` by default, and the passwords will be the first things in the in container's logs.

Which you can see with this command:

```
docker logs $(cat na.cid)
```

In this case you can now access your 'mirror', by going to (replace localhost with your IP or resolvable domain name):
[http://localhost:8000/mirror](http://localhost:8000/mirror)
and the username would `NAlocal512` and the password would be what you found in the logs above labeled as `ADMIN_PASSWORD`. 

## Details

### Run 

By setting some env vars
you can set the passwords like so:

```
docker run \
  -d \
  -p 8000:8000 \
  --cidfile na.cid \
  --name noagendastream-mirror \
  -e  noagendastream-mirror \
  -e SOURCE_PASSWORD=testing123 \
  -e RELAY_PASSWORD=testing123 \
  -e ADMIN_PASSWORD=testing123 \
  -e TARGET_HOSTNAME=localhost \
  -e TARGET_LOCATION=Austin \
  -e TARGET_ADMIN_EMAIL='testmaster@localhost' \
  -e TARGET_ADMIN_USER=funkyadmin \
  -v logs:/var/log/icecast2 \
  -t nalocal512/noagendastream-mirror
```

In this case you can now access your 'mirror' by going to 
[http://localhost:8000/mirror](http://localhost:8000/mirror)
and the username would `funkyadmin` and the password would be `testing123`.  Adjust those values accordingly in your `docker run` command, most importantly would be `TARGET_HOSTNAME` which you should set to a local domain name or IP address so that external computers around your LAN can access the relay.

### Build

You can build locally:

```
  docker build -t nalocal512/noagendastream-mirror .
```
