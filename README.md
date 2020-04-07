docker build -t mysql:5.7.14 .
docker run -d -e MYSQL_ROOT_PASSWORD=passwd mysql:5.7.14
