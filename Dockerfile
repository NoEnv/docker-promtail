FROM registry.fedoraproject.org/fedora-minimal:37 as build

ARG VERSION=2.7.5

WORKDIR /src

RUN microdnf -y --nodocs install hostname make protobuf-devel golang git \
  golang-github-gogo-protobuf systemd-devel
RUN git clone --depth 1 --branch v${VERSION} https://github.com/grafana/loki.git /src
RUN make clean && make BUILD_IN_CONTAINER=false promtail

FROM registry.fedoraproject.org/fedora-minimal:37

RUN microdnf -y --nodocs install systemd-libs && microdnf clean all && rm -rf /var/lib/dnf /var/cache/*

ENV ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH=go1.18

COPY --from=build /src/clients/cmd/promtail/promtail /usr/bin/promtail
COPY --from=build /src/clients/cmd/promtail/promtail-docker-config.yaml /etc/promtail/config.yml

ENTRYPOINT ["/usr/bin/promtail"]

CMD ["-config.file=/etc/promtail/config.yml"]
