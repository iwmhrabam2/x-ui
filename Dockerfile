FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build main.go

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root
COPY --from=builder /root/main /root/x-ui
COPY bin/. /root/bin/
CMD ["./x-ui"]
