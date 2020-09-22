all: clean build random logs

alpine: clean build-alpine random-alpine logs

build:
	docker build \
		-t nalocal512/noagendastream-mirror \
		.

build-alpine:
	docker build \
		-f Dockerfile.alpine \
		-t nalocal512/noagendastream-mirror:alpine \
		.

random:
	docker run \
		-d \
		-e RELAY_MODE=all \
		-p 0.0.0.0:8000:8000 \
		--cidfile na.cid \
		nalocal512/noagendastream-mirror

random-alpine:
	docker run \
		-e RELAY_MODE=all \
		-d \
		-p 0.0.0.0:8000:8000 \
		--cidfile na.cid \
		nalocal512/noagendastream-mirror:alpine

run:
	docker run \
		-d \
		-p 0.0.0.0:8000:8000 \
		--cidfile na.cid \
		--name noagendastream-mirror \
		-e RELAY_MODE=all \
		-v logs:/var/log/icecast2 \
		-t nalocal512/noagendastream-mirror

runtest:
	docker run \
		-d \
		-p 0.0.0.0:8000:8000 \
		--cidfile na.cid \
		--name noagendastream-mirror \
		-e SOURCE_PASSWORD=testing123 \
		-e RELAY_PASSWORD=testing123 \
		-e RELAY_MODE=all \
		-e ADMIN_PASSWORD=testing123 \
		-e TARGET_HOSTNAME=localhost \
		-e TARGET_LOCATION=Earth \
		-e TARGET_ADMIN_EMAIL='testmaster@localhost' \
		-e TARGET_ADMIN_USER=funkyadmin \
		-v logs:/var/log/icecast2 \
		-t nalocal512/noagendastream-mirror

runnormal:
	docker run \
		-d \
		-p 0.0.0.0:8000:8000 \
		--cidfile na.cid \
		--name noagendastream-mirror \
		-e RELAY_MODE=normal \
		-v logs:/var/log/icecast2 \
		-t nalocal512/noagendastream-mirror

clean:
	-@docker kill `cat na.cid`
	-@docker rm `cat na.cid`
	-@rm na.cid

logs:
	$(eval CID := $(shell cat na.cid))
	docker logs ${CID}

enter:
	$(eval CID := $(shell cat na.cid))
	docker exec -it ${CID} /bin/bash
