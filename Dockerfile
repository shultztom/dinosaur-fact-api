FROM node:lts-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package.json package-lock.json ./

# RUN npm install --production
# If you are building your code for production
RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 8080
USER node
CMD [ "npm", "run", "start" ]