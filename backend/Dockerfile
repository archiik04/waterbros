FROM node:20-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package descriptors and install production-only dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy remaining source code (excluding files in .dockerignore)
COPY . .

# Expose Node.js application port
EXPOSE 8000

# Start production server
CMD [ "node", "src/app.js" ]
