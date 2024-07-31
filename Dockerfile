FROM node:20-bookworm-slim

VOLUME /app/external

WORKDIR /app
RUN chown node:node /app
USER node

COPY --chown=node:node .yarn .yarn
COPY --chown=node:node build build

# Sets the TMPDIR for yarn, in case the EPERM error is related to the /tmp directory
# Unfortunately, the same EPERM error occurs (with the updated path)
#RUN mkdir -p /app/.yarn/tmp  && chown node:node /app/.yarn/tmp
#ENV TMPDIR=/app/.yarn/tmp

COPY --chown=node:node .yarnrc.yml package.json express.js build-external.js .
RUN yarn install

ENTRYPOINT ["node", "express.js"]
