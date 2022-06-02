FROM python:3.6-alpine3.10
#
COPY .  /ColdStartService
WORKDIR /ColdStartService/
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.cloud.tencent.com/g' /etc/apk/repositories \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone \
    && pip  install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --default-timeout=10000 -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
WORKDIR /ColdStartService/main/
EXPOSE 80
CMD ["python3","/ColdStartService/main/service.py"]
