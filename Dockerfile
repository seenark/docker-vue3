FROM node:12.18-alpine as builder
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install
COPY . .
EXPOSE 8080
RUN npm run build
# CMD ["npm", "start"]

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
