FROM openresty/openresty:1.15.8.3-alpine

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    echo "http://mirrors.tencentyun.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main" >/etc/apk/repositories && \
    echo "http://mirrors.tencentyun.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community" >>/etc/apk/repositories && \
    echo "http://mirrors.cloud.tencent.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main" >>/etc/apk/repositories && \
    echo "http://mirrors.cloud.tencent.com/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community" >>/etc/apk/repositories

COPY *.lua /usr/local/openresty/nginx/conf/
COPY nginx.conf /usr/local/openresty/nginx/conf/
COPY default.conf /etc/nginx/conf.d/
