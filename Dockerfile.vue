FROM node:lts-alpine

RUN npm install -g http-server

WORKDIR /app
COPY . /app


RUN npm install --production

RUN npm run build

EXPOSE 80
CMD [ "http-server", "dist" ]
