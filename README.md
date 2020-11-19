[![Docker Pulls](https://badgen.net/docker/pulls/noenv/promtail)](https://hub.docker.com/r/noenv/promtail)

## docker-promtail

#### Description

Promtail as Docker Image.

Based on the latest stable fedora release to run on Fedora CoreOS.

#### Run

most simple way of running the container

    docker run -d --name promtail -v /var/log:/var/log noenv/promtail
