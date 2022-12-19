# build
FROM docker.io/library/node:18.12.1-alpine as build

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

COPY . ./

RUN npm i

RUN rm -rf node_modules

RUN npm i --production

# prod
FROM gcr.io/distroless/nodejs18-debian11

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/server.js .
COPY --from=build /usr/src/app/node_modules node_modules

EXPOSE 3000

CMD ["server"]
