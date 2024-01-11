FROM --platform=$BUILDPLATFORM golang:1.21.6 AS build
ARG TARGETARCH

WORKDIR /go/src/github.com/gihyodocker/image-bootstrap
COPY . .

RUN GOARCH=${TARGETARCH} go build -o bin/server main.go

FROM gcr.io/distroless/base-debian11:nonroot
LABEL org.opencontainers.image.source=https://github.com/gihyodocker/image-bootstrap

COPY --from=build --chown=nonroot:nonroot /go/src/github.com/gihyodocker/image-bootstrap/bin/server /usr/local/bin/

USER nonroot

CMD ["server"]
