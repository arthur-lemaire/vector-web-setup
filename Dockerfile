FROM node:10-alpine
# Create app directory
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
RUN npm install -g vector-web-setup
RUN vector-web-setup configure
RUN vector-web-setup ota-sync
# If you are building your code for production
# RUN npm ci --only=production
COPY --chown=node:node . .

EXPOSE 8081
CMD [ "node", "run.js" ]
