FROM registry.fedoraproject.org/fedora-minimal:35 as build

ARG VERSION=2.4.0

WORKDIR /src

RUN microdnf -y install hostname make protobuf-devel golang \
  golang-github-gogo-protobuf systemd-devel
RUN git clone --depth 1 --branch v${VERSION} https://github.com/grafana/loki.git /src
RUN make clean && make touch-protos && make BUILD_IN_CONTAINER=false promtail

FROM registry.fedoraproject.org/fedora-minimal:35

COPY --from=build /src/clients/cmd/promtail/promtail /usr/bin/promtail
COPY --from=build /src/clients/cmd/promtail/promtail-docker-config.yaml /etc/promtail/config.yml

ENTRYPOINT ["/usr/bin/promtail"]

CMD ["-config.file=/etc/promtail/config.yml"]
