FROM ruby:3.3.10-alpine3.22@sha256:33c684437f1d651cc9200b9e9554a815f020f5bb63593fadbd49d50acd29f0e3
LABEL maintainer=jon@jaggersoft.com

ARG COMMIT_SHA
ENV SHA=${COMMIT_SHA}

RUN apk --update --upgrade --no-cache add \
    bash \
    tini \
    procps \
    tar

RUN apk upgrade
RUN apk add --upgrade expat=2.7.5-r0    # https://security.snyk.io/vuln/SNYK-ALPINE322-EXPAT-15704589
RUN apk add --upgrade c-ares=1.34.6-r0  # https://security.snyk.io/vuln/SNYK-ALPINE322-CARES-14409293
RUN apk add --upgrade openssl=3.5.5-r0  # https://security.snyk.io/vuln/SNYK-ALPINE322-OPENSSL-15121113

WORKDIR /app
COPY Gemfile .

RUN apk add --update --upgrade --virtual build-dependencies build-base \
  && bundle config set force_ruby_platform true \
  && bundle install \
  && gem clean \
  && apk del build-dependencies build-base \
     rm -vrf /usr/lib/ruby/gems/*/cache/* \
             /var/cache/apk/* \
             /tmp/* \
             /var/tmp/*

COPY source/ .
HEALTHCHECK --interval=1s --timeout=1s --retries=5 --start-period=5s CMD ./config/healthcheck.sh
ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD [ "./config/up.sh" ]

