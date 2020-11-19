FROM fedora:33 as build

ARG VERSION=2.0.0

WORKDIR /src

RUN dnf -y update && \
  dnf -y install hostname make protobuf-devel golang \
  golang-github-gogo-protobuf systemd-devel
RUN git clone --depth 1 --branch v${VERSION} https://github.com/grafana/loki.git /src
RUN make clean && make touch-protos && make BUILD_IN_CONTAINER=false promtail

FROM fedora:33

RUN dnf -y update && \
  dnf -y install tzdata ca-certificates systemd-libs && \
  dnf clean all && \
  rm -rf /var/lib/dnf/repos/* /tmp/* /var/tmp/*

COPY --from=build /src/cmd/promtail/promtail /usr/bin/promtail
COPY --from=build /src/cmd/promtail/promtail-docker-config.yaml /etc/promtail/config.yml

ENTRYPOINT ["/usr/bin/promtail"]

CMD ["-config.file=/etc/promtail/config.yml"]
