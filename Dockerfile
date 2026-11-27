FROM mcr.microsoft.com/playwright:v1.63.0-noble

# Playwright browsers ka path set karein
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV HOME=/app
ENV NODE_ENV=production

WORKDIR /app

# System dependencies (pkill ke liye procps zaroori hai)
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install --omit=dev

# Browser binaries ensure karein
RUN npx playwright install chromium && chmod -R 777 /ms-playwright

COPY . .

# Hostless ke liye .cache folder writable banayein
RUN mkdir -p /app/.cache/app-data && chmod -R 777 /app/.cache

EXPOSE 8080

CMD ["npm", "start"]
