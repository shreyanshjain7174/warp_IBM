FROM golang:1.18 AS builder

WORKDIR /go/src/github.com/shreyanshjain7174/warp_IBM

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -ldflags '-w -s' -a -o warp .

FROM alpine
MAINTAINER MinIO Development "dev@min.io"
EXPOSE 7761

COPY --from=builder /go/src/github.com/shreyanshjain7174/warp_IBM/warp /warp

ENTRYPOINT ["/warp"]
