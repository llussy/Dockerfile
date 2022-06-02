FROM debian:stretch
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ADD sources.list /etc/apt/sources.list
RUN rm -rf /etc/apt/sources.list.d/buster.list
#RUN sed -i 's#[a-z]\+.debian.org#mirrors.aliyun.com#g' /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        gettext-base \
        gnupg2 \
        lsb-release \
        software-properties-common \
        wget \
	unzip \
	patch \
	gcc \
	make libpcre3 libpcre3-dev openssl libssl-dev libperl-dev zlib1g-dev \
    && mkdir -p /etc/nginx/conf.d \
    && cd /usr/local/ \
    && wget http://nginx.org/download/nginx-1.16.1.tar.gz \
    && tar -xzvf nginx-1.16.1.tar.gz \
	&& cd nginx-1.16.1/ \
	&& wget https://github.com/yaoweibin/nginx_upstream_check_module/archive/master.zip \
	&& unzip master.zip \
	&& patch -p1 < /usr/local/nginx-1.16.1/nginx_upstream_check_module-master/check_1.16.1+.patch \
	&& ./configure --prefix=/usr/local/nginx --with-http_stub_status_module \
	--with-http_gzip_static_module --with-pcre --with-debug \
	--add-module=/usr/local/nginx-1.16.1/nginx_upstream_check_module-master \
	&& make -j4 \
	&& make -j4 install \	
    && DEBIAN_FRONTEND=noninteractive apt-get remove -y --purge \
        gnupg2 \
        lsb-release \
        software-properties-common \
        wget \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

# Add additional binaries into PATH for convenience
ENV PATH=$PATH:/usr/local/nginx/sbin/

##########配置文件和测试包###########
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

STOPSIGNAL SIGTERM
