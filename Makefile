build:
	docker build \
	  -t nalocal512/noagendastream-mirror \
		.

random:
	docker run -d -P --cidfile na.cid nalocal512/noagendastream-mirror

run:
	docker run \
		-d \
		-p 8000:8000 \
		--cidfile na.cid \
	  --name noagendastream-mirror \
    -e SOURCE_PASSWORD=testing123 \
    -e RELAY_PASSWORD=testing123 \
    -e ADMIN_PASSWORD=testing123 \
    -e TARGET_HOSTNAME=localhost \
    -e TARGET_LOCATION=Earth \
    -e TARGET_ADMIN_EMAIL='testmaster@localhost' \
    -e TARGET_ADMIN_USER=funkyadmin \
		-v logs:/var/log/icecast2 \
	  -t nalocal512/noagendastream-mirror

clean:
	-docker kill `cat na.cid`
	-docker rm `cat na.cid`
	rm na.cid

logs:
	$(eval CID := $(shell cat na.cid))
	docker logs ${CID}
