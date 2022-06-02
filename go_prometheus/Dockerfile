FROM golang:1.13-alpine3.12 as small
COPY prometheus_http.go /
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone  && \ 
    echo "http://mirrors.tencentyun.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main" >/etc/apk/repositories && \
    echo "http://mirrors.tencentyun.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community" >>/etc/apk/repositories && \
    echo "http://mirrors.cloud.tencent.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main" >>/etc/apk/repositories && \
    echo "http://mirrors.cloud.tencent.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community" >>/etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps git
RUN go get -u -v github.com/prometheus/client_golang/prometheus && \
    go get -v -u github.com/prometheus/client_golang/prometheus/promhttp
RUN go build /prometheus_http.go
RUN apk del .build-deps
CMD ["/go/prometheus_http"]
