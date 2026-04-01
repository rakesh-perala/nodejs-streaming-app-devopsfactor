# Use lightweight image
FROM node:20-alpine

WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy rest of the code
COPY . .

EXPOSE 3000

CMD ["node", "app.js"]
