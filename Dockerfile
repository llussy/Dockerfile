FROM golang:1.14 as build-env

COPY . /root

WORKDIR /root

RUN \
  export GO111MODULE=on &&\
  export GOPROXY=https://goproxy.io &&\
  go build -o project &&\
  mv project / &&\
  rm -rf /root/*

FROM ubuntu:16.04
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build-env /project /project
EXPOSE 9090
CMD ["/project"]

# docker run -it --rm  -p 9090:9090 project:v1