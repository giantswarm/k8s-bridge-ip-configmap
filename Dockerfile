FROM bashell/alpine-bash

RUN apk update \
  && apk upgrade \
  && apk add iptables \
  && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
