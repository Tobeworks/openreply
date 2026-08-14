# ponytail: single stage — der Worker braucht tsx (devDependency), also bleiben
# die devDeps sowieso im Image. Multi-stage/standalone erst, wenn Pull-Zeit stört.
FROM node:22-alpine
WORKDIR /app

# Prisma braucht openssl auf alpine
RUN apk add --no-cache openssl

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

EXPOSE 3000
# Web: dieses CMD. Worker: command im Deployment überschrieben (npm run worker).
CMD ["npm", "start"]
