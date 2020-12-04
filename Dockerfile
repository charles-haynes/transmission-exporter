# This is the builder container
FROM golang:latest AS builder
WORKDIR /app

ADD . /app/

RUN make build

FROM alpine:latest
RUN apk add --update ca-certificates

WORKDIR /

COPY --from=builder /app/transmission-exporter /app/transmission-exporter

EXPOSE 19091

ENTRYPOINT ["/app/transmission-exporter"]
