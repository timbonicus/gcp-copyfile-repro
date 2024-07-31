FROM node:20-bookworm-slim

VOLUME /app/external

WORKDIR /app
RUN chown node:node /app
USER node

# Sets the TMPDIR for yarn/node, in case the EPERM error is related to the /tmp directory
# Unfortunately, the same EPERM error occurs (this time copying from /app/tmp to /app/external)
#RUN mkdir -p /app/tmp  && chown node:node /app/tmp
#ENV TMPDIR=/app/tmp

COPY --chown=node:node .yarn .yarn
COPY --chown=node:node build build

COPY --chown=node:node .yarnrc.yml package.json express.js build-external.js .
RUN yarn install

ENTRYPOINT ["node", "express.js"]
