FROM node:latest

EXPOSE 8080
VOLUME /app/external

WORKDIR /app
COPY build build

COPY .yarnrc.yml package.json express.js build-external.js .
RUN corepack enable
RUN corepack prepare yarn@stable --activate
RUN yarn install

ENTRYPOINT ["node", "express.js"]
