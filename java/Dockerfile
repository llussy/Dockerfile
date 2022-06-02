FROM maven:3.5.0-jdk-8-alpine AS build

RUN echo $' \n\
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 \n\
    https://maven.apache.org/xsd/settings-1.0.0.xsd"> \n\
    <mirrors> \n\
    <mirror> \n\
    <id>nexus-wieof</id> \n\
    <mirrorOf>*</mirrorOf> \n\
    <name>Nexus wieof</name> \n\
    <url>http://local-maven.wieof.com/repository/maven-public/</url> \n\
    </mirror> \n\
    </mirrors> \n\
</settings> '> /usr/share/maven/ref/settings-docker.xml

ADD . /tmp/

RUN cd /tmp/ && \
    mvn clean package -DskipTests -gs /usr/share/maven/ref/settings-docker.xml

FROM openjdk:8u131-jre-alpine

COPY --from=build /tmp/xxx/xxxx/*.jar /xxxx.jar

RUN mkdir -p /xxx/logs \
    &&  echo ''> /xxx/logs/access.log \
    && ln -sf /dev/stdout  /xxx/logs/access.log

EXPOSE 8080

CMD ["java", \
    "-Xms500m", \
    "-Xmx3800m", \
    "-XX:+UnlockExperimentalVMOptions", \
    "-XX:+UseCGroupMemoryLimitForHeap", \
    "-XX:+UseG1GC", \
    "-Duser.timezone=Asia/Shanghai", \
    "-jar", \
    "/xxxx.jar", \
    "--spring.profiles.active=qa","-c"]
