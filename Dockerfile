# Build stage
ARG goversion

FROM --platform=${BUILDPLATFORM} golang:${goversion}-alpine as builder

WORKDIR /spire
RUN apk add build-base git mercurial
COPY go.mod go.sum /spire/
RUN go mod download
COPY . /spire/
ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} make build

# Common base
FROM --platform=${TARGETPLATFORM} alpine AS spire-base
RUN apk --no-cache add dumb-init
RUN apk --no-cache add ca-certificates
RUN mkdir -p /opt/spire/bin

# SPIRE Server
FROM spire-base AS spire-server
COPY --from=builder /spire/bin/spire-server /opt/spire/bin/spire-server
WORKDIR /opt/spire
ENTRYPOINT ["/usr/bin/dumb-init", "/opt/spire/bin/spire-server", "run"]
CMD []

# SPIRE Agent
FROM spire-base AS spire-agent
COPY --from=builder /spire/bin/spire-agent /opt/spire/bin/spire-agent
WORKDIR /opt/spire
ENTRYPOINT ["/usr/bin/dumb-init", "/opt/spire/bin/spire-agent", "run"]
CMD []

# K8S Workload Registrar
FROM spire-base AS k8s-workload-registrar
COPY --from=builder /spire/bin/k8s-workload-registrar /opt/spire/bin/k8s-workload-registrar
WORKDIR /opt/spire
ENTRYPOINT ["/usr/bin/dumb-init", "/opt/spire/bin/k8s-workload-registrar"]
CMD []

# OIDC Discovery Provider
FROM spire-base AS oidc-discovery-provider
COPY --from=builder /spire/bin/oidc-discovery-provider /opt/spire/bin/oidc-discovery-provider
WORKDIR /opt/spire
ENTRYPOINT ["/usr/bin/dumb-init", "/opt/spire/bin/oidc-discovery-provider"]
CMD []
