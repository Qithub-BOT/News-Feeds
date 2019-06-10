FROM keinos/gofeed-cli:latest

RUN apk add --update \
      jq bash

COPY . /src
WORKDIR /src
