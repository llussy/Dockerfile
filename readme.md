docker build -t node:test . -f Dockerfile

docker run -p 80:8080 -d node:test

curl localhost

TODO: combine nginx
