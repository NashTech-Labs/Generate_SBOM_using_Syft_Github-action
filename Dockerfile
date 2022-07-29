# syntax=docker/dockerfile:1

FROM node:14

LABEL author="kirti.ghugtyal@knoldus.com"

WORKDIR /usr/src/app

RUN npm install

COPY . .

CMD [ "npm", "run", "dev" ]
