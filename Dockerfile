# Use official Node.js LTS image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (including express-ejs-layouts)
RUN npm install

# Copy the rest of the app code
COPY . .

# Expose the port your app uses
EXPOSE 3000

# Command to run the app
CMD ["node", "app.js"]
