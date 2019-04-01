FROM ruby:2.6

LABEL name="rmoraes/indexer"
LABEL version="0.0.1"
LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile* /tmp/

RUN cd /tmp && bundle install

WORKDIR /development
EXPOSE 3000
