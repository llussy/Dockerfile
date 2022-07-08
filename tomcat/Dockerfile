#base image
FROM maven:3.5.0-jdk-8-alpine AS build

ADD . /tmp/

RUN cd /tmp/ \
    && mvn clean package -P online

FROM tomcat:9.0.1-jre8-alpine

WORKDIR /usr/local/tomcat/webapps

RUN sed -i "1 a JAVA_OPTS='-Xms1800m -Xmx1800m'" /usr/local/tomcat/bin/catalina.sh \
    && rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /tmp/target/*.war /usr/local/tomcat/webapps/ROOT.war

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

EXPOSE 8080

ENTRYPOINT ["sh","/usr/local/tomcat/bin/catalina.sh","run"]

