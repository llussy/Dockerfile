FROM alpine:3.7
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.7/main/" > /etc/apk/repositories

RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash