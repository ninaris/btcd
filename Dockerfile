FROM golang:1.10.3-alpine3.7 AS build

RUN apk add --no-cache gcc
RUN apk add --no-cache musl-dev

COPY . /go/src/github.com/btcsuite/btcd/
WORKDIR /go/src/github.com/btcsuite/btcd/

RUN	go build -o /bin/btcd github.com/btcsuite/btcd
RUN	go build -o /bin/btcctl github.com/btcsuite/btcd/cmd/btcctl

FROM alpine:3.7
COPY --from=build /bin/btcd /bin/btcd
COPY --from=build /bin/btcctl /bin/btcctl
