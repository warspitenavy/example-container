FROM docker.io/library/node:18.12.1-alpine as build

WORKDIR /usr/src/app

COPY . ./

RUN npm i --production

FROM gcr.io/distroless/nodejs18

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/server.js .
COPY --from=build /usr/src/app/node_modules node_modules

EXPOSE 3000

CMD ["server"]
