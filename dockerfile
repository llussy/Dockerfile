FROM node:lts-alpine

WORKDIR /app
COPY . /app/

RUN npm config set registry https://registry.npm.taobao.org --global && \
	npm config set disturl https://npm.taobao.org/dist --global  


RUN npm install

COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]
