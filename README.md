# maven-jdk

```bash
FROM maven:3.6-jdk-8-alpine AS build
ADD . /tmp/

RUN mkdir -p /data/project \
    && cd /tmp/ \
    && mvn clean package -P release

FROM openjdk:8u131-jre-alpine

WORKDIR /data/project

COPY --from=build /tmp/target/*.jar /data/project/project.jar

EXPOSE 8080

CMD ["java", \
    "-Xmx1G", \
    "-Xms1G", \
    "-XX:+UseG1GC", \
    "-Duser.timezone=Asia/Shanghai", \
    "-jar", \
    "project.jar"]
```
