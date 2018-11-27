ARG DOCKER_REPO=openjdk
ARG DOCKER_TAG=8-alpine
FROM ${DOCKER_REPO}:${DOCKER_TAG}

# Add a user with a group
RUN addgroup -S app && \
    adduser -h /home/app -S -D -G app app

RUN mkdir /app
ADD output/SimpleHTTPServer.jar /app/
ADD scripts/container-init.sh /app/init.sh

# NOTE: It is better to have an install script using install which will
# put the file in place without needing to change permissions afterwards
RUN find /app -type d -exec chmod 0755 {} \; && \
    find /app -type f -exec chmod 0644 {} \; && \
    chmod 755 /app/init.sh

EXPOSE 8000

USER app
ENTRYPOINT /app/init.sh
