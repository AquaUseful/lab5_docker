# build

FROM node:latest as build
WORKDIR /app

COPY SnapShot .
COPY package.json.patch ./

RUN patch package.json package.json.patch

RUN npm update
RUN npm install
RUN npm run build

# deploy
FROM nginx
COPY --from=build /app/build /usr/share/nginx/html/SnapShot
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
