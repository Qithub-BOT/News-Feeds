FROM keinos/gofeed-cli:latest

RUN apk add --update \
      jq bash

COPY list_url_feeds_nice.json /src/list_url_feeds_nice.json
COPY list_url_feeds_niche.json /src/list_url_feeds_niche.json

WORKDIR /src
