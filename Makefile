BASE_DOCKER_IMAGE = openjdk:8-alpine
DOCKER_REPO = local/java-sample
DOCKER_TAG = local
UID = $(shell id -u)

help:
	@echo "This is just a help line..."

build:
	@ci-scripts/build.sh

build-container: build-containerized
	docker build -t ${DOCKER_REPO}:${DOCKER_TAG} .

build-containerized:
	docker run -u ${UID}:${UID} -ti --rm -v "${PWD}:/build" -w /build ${BASE_DOCKER_IMAGE} ci-scripts/build.sh

run: build-container
	docker run -u ${UID}:${UID} -ti --rm -P ${DOCKER_REPO}:${DOCKER_TAG}

clean:
	rm -rf output/*
