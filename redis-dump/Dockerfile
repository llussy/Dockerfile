FROM redis:5
RUN sed -i "s#[a-z]\+.debian.org#mirrors.cloud.tencent.com#g" /etc/apt/sources.list
RUN apt-get update && apt-get install ruby-dev -y \
    && apt-get install make procps -y \
    && apt-get install gcc -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gem install redis-dump -V
