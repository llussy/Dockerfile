FROM node:lts-alpine AS builder

RUN npm config set registry https://registry.npm.taobao.org --global && \
	npm config set disturl https://npm.taobao.org/dist --global

WORKDIR /app
COPY . /app

RUN npm install

RUN npm run build

FROM nginx
COPY --from=builder /app/dist  /usr/share/nginx/html
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
