FROM node:latest

EXPOSE 8080
VOLUME /app/external

WORKDIR /app
COPY build build

COPY package.json express.js build-external.js .
RUN yarn install

ENTRYPOINT ["node", "express.js"]
