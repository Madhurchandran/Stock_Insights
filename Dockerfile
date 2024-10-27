FROM node:18 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production && npm cache clean --force
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]