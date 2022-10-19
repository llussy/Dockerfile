FROM node:lts-alpine

WORKDIR /app
COPY . /app/

EXPOSE 8089
CMD [ "node", "/app/server.js" ]
