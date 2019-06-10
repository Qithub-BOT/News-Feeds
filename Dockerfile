FROM keinos/gofeed-cli:latest

RUN apk add --update \
      jq bash

WORKDIR /src
