[![Docker Pulls](https://badgen.net/docker/pulls/noenv/promtail)](https://hub.docker.com/r/noenv/promtail)
[![Quay.io Enabled](https://badgen.net/badge/quay%20pulls/enabled/green)](https://quay.io/repository/noenv/promtail)
[![build](https://github.com/NoEnv/docker-promtail/actions/workflows/build.yml/badge.svg)](https://github.com/NoEnv/docker-promtail/actions/workflows/build.yml)

## docker-promtail

#### Description

Promtail as Docker Image.

Based on the latest stable fedora release to run on Fedora CoreOS.

#### Run

most simple way of running the container

    docker run -d --name promtail -v /var/log:/var/log noenv/promtail
