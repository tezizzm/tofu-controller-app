FROM node:18-alpine AS builder

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Copy your source (single-file here)
COPY index.js ./

# Final runtime image
FROM node:18-alpine
WORKDIR /usr/src/app

# Create non-root user
RUN addgroup -S app && adduser -S -G app app

# Copy only production artifacts
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/index.js ./index.js

USER app
EXPOSE 3000
CMD ["node", "index.js"]