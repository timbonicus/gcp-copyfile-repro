FROM node:20-bookworm-slim

VOLUME /app/external

WORKDIR /app
RUN chown node:node /app
USER node
COPY --chown=node:node .yarn .yarn
COPY --chown=node:node build build

COPY --chown=node:node .yarnrc.yml package.json express.js build-external.js .
RUN yarn install

ENTRYPOINT ["node", "express.js"]
